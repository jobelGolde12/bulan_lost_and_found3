<?php

namespace App\Http\Controllers;

use App\Models\ItemModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class FindMatchController extends Controller
{
    public function index(Request $request)
    {
        $items = ItemModel::all();
        Log::info(['items => ' => $items->toArray()]);

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
                // Normalize category - require exact category match
                $lostCategory = strtolower(trim($lostItem->category));
                $foundCategory = strtolower(trim($foundItem->category));

                // Category must match exactly
                if ($lostCategory !== $foundCategory) {
                    return false;
                }

                // Combine title + description words for both items
                $lostText = strtolower(trim(($lostItem->title ?? '') . ' ' . ($lostItem->description ?? '')));
                $foundText = strtolower(trim(($foundItem->title ?? '') . ' ' . ($foundItem->description ?? '')));

                // Split into words
                $lostWords = array_unique(preg_split('/\s+/', $lostText));
                $foundWords = array_unique(preg_split('/\s+/', $foundText));

                // Remove filler words
                $stopWords = ['a', 'an', 'the', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 'of', 'with', 'by', 'is', 'it', 'this', 'that', 'from'];
                $lostWords = array_diff($lostWords, $stopWords);
                $foundWords = array_diff($foundWords, $stopWords);

                // --- Improved matching logic ---

                $sharedWords = [];
                foreach ($lostWords as $lw) {
                    foreach ($foundWords as $fw) {
                        similar_text($lw, $fw, $percent);
                        // consider words similar if 70% or more alike
                        if ($percent >= 70) {
                            $sharedWords[] = $lw;
                            break;
                        }
                    }
                }

                // --- Enhanced keyword logic ---
                $keywordMatch = true;
                if (!empty($keyword)) {
                    $keywordMatch = false;
                    // check if keyword appears anywhere in the text
                    if (str_contains($lostText, $keyword) || str_contains($foundText, $keyword)) {
                        $keywordMatch = true;
                    } else {
                        // fuzzy keyword matching
                        foreach (array_merge($lostWords, $foundWords) as $word) {
                            similar_text($keyword, $word, $percent);
                            if ($percent >= 70) {
                                $keywordMatch = true;
                                break;
                            }
                        }
                    }
                }

                // Return true if there are shared words AND keyword roughly matches
                return !empty($sharedWords) && $keywordMatch;
            });

            if ($matchedLostItems->isNotEmpty()) {
                $matches[] = [
                    'foundItem' => $foundItem,
                    'matchedLostItems' => $matchedLostItems->values(),
                ];
            }
        }

        return Inertia::render('admin/FindMatch', [
            'matches' => $matches,
        ]);
    }
}
