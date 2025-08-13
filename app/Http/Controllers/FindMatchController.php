<?php

namespace App\Http\Controllers;

use App\Models\ItemModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Str;
use Inertia\Inertia;

class FindMatchController extends Controller
{
    public function index(Request $request)
    {
        $keyword = strtolower(trim($request->input('keyword')));

        // Load all lost items
        $lostItems = ItemModel::with(['user', 'user.userInfo' => function ($query) {
            $query->select('id', 'profile_pic', 'user_id');
        }])
        ->where('status', 'Lost')
        ->get();

        // Load all found items
        $foundItems = ItemModel::with(['user', 'user.userInfo' => function ($query) {
            $query->select('id', 'profile_pic', 'user_id');
        }])
        ->where('status', 'Found')
        ->get();

        $matches = [];

        foreach ($foundItems as $foundItem) {
            $matchedLostItems = $lostItems->filter(function ($lostItem) use ($foundItem, $keyword) {
                // Normalize location
                $lostLocation = strtolower(trim($lostItem->location));
                $foundLocation = strtolower(trim($foundItem->location));

                // Require location match
                $locationMatch = $lostLocation === $foundLocation;

                // Combine text fields for similarity
                $lostText = strtolower($lostItem->title . ' ' . $lostItem->description);
                $foundText = strtolower($foundItem->title . ' ' . $foundItem->description);

                // Use keyword if provided, otherwise fallback to found item's title
                $searchKeyword = $keyword ?: strtolower($foundItem->title);

                // Check if keyword appears in either item's text
                $keywordMatch = Str::contains($lostText, $searchKeyword) || Str::contains($foundText, $searchKeyword);

                // Check for shared keywords like "bike", "black", etc.
                $commonWords = ['bike', 'black', 'mountain', 'bag', 'phone', 'wallet'];
                $textMatch = false;
                foreach ($commonWords as $word) {
                    if (Str::contains($lostText, $word) && Str::contains($foundText, $word)) {
                        $textMatch = true;
                        break;
                    }
                }

                return $locationMatch && ($keywordMatch || $textMatch);
            });

            if ($matchedLostItems->isNotEmpty()) {
                $matches[] = [
                    'foundItem' => $foundItem,
                    'matchedLostItems' => $matchedLostItems->values()
                ];

                Log::info("Found item ID {$foundItem->id} matched with " . $matchedLostItems->count() . " lost items.");
            }
        }

        return Inertia::render('admin/FindMatch', [
            'matches' => $matches,
        ]);
    }
}