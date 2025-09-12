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
                // Normalize location & category
                $lostLocation = strtolower(trim($lostItem->location));
                $foundLocation = strtolower(trim($foundItem->location));
                $lostCategory = strtolower(trim($lostItem->category));
                $foundCategory = strtolower(trim($foundItem->category));

                // Require location + category match
                if ($lostLocation !== $foundLocation || $lostCategory !== $foundCategory) {
                    return false;
                }

                // Break titles into words
                $lostTitleWords = array_unique(preg_split('/\s+/', strtolower($lostItem->title)));
                $foundTitleWords = array_unique(preg_split('/\s+/', strtolower($foundItem->title)));

                // Check if at least one word from found title exists in lost title
                $sharedWords = array_intersect($lostTitleWords, $foundTitleWords);

                // If keyword is provided, enforce that it must be present in title
                $keywordMatch = true;
                if ($keyword) {
                    $keywordMatch = in_array($keyword, $lostTitleWords) || in_array($keyword, $foundTitleWords);
                }

                return !empty($sharedWords) && $keywordMatch;
            });

            if ($matchedLostItems->isNotEmpty()) {
                $matches[] = [
                    'foundItem' => $foundItem,
                    'matchedLostItems' => $matchedLostItems->values()
                ];
            }
        }

        return Inertia::render('admin/FindMatch', [
            'matches' => $matches,
        ]);
    }
}
