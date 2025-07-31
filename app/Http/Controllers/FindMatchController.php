<?php

namespace App\Http\Controllers;

use App\Models\ItemModel;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Inertia\Inertia;

class FindMatchController extends Controller
{
    public function index(Request $request)
    {
        $keyword = $request->input('keyword');

        $lostItems = ItemModel::with(['user', 'user.userInfo' => function ($query) {
            $query->select('id', 'profile_pic', 'user_id');
        }])
        ->where('status', 'Lost')
        ->get();

        $foundItems = ItemModel::with(['user', 'user.userInfo' => function ($query) {
            $query->select('id', 'profile_pic', 'user_id');
        }])
        ->where('status', 'Found')
        ->get();

        // Match the item
        $matches = $foundItems->map(function ($foundItem) use ($lostItems, $keyword) {
            $matchedLostItems = $lostItems->filter(function ($lostItem) use ($foundItem, $keyword) {
                // Basic matching: same category + location
                $basicMatch = strtolower($lostItem->category) === strtolower($foundItem->category) &&
                              strtolower($lostItem->location) === strtolower($foundItem->location);

                // Keyword matching: if keyword appears in any field of either item
                $keywordMatch = false;
                if ($keyword) {
                    $keyword = strtolower($keyword);
                    $allFields = [
                        strtolower($lostItem->title),
                        strtolower($lostItem->description),
                        strtolower($lostItem->location),
                        strtolower($lostItem->category),
                        strtolower($foundItem->title),
                        strtolower($foundItem->description),
                        strtolower($foundItem->location),
                        strtolower($foundItem->category),
                    ];

                    foreach ($allFields as $field) {
                        if ($field && Str::contains($field, $keyword)) {
                            $keywordMatch = true;
                            break;
                        }
                    }
                }

                return $basicMatch || $keywordMatch;
            });

            if ($matchedLostItems->isNotEmpty()) {
                return [
                    'foundItem' => $foundItem,
                    'matchedLostItems' => $matchedLostItems->values()
                ];
            }

            return null; // skip if no match
        })->filter(); // remove nulls

        return Inertia::render('admin/FindMatch', [
            'matches' => $matches,
        ]);
    }
}
