<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ItemModel;
use Illuminate\Http\Request;

class StorageCleaner extends Controller
{
      public function deleteClaimed(Request $request)
    {
        // Update claimed items: clear extra fields, keep essentials
        ItemModel::where('status', 'claimed')->update([
            'description' => null,
            'category' => null,
            'contact_info' => null,
            'image_url' => null,
            'resolved_at' => null,
            'category_id' => null,
            'owner_phone_number' => null,
            // keep title, location, user_id, status
            'updated_at' => now(),
        ]);

        return redirect()->route('dashboard')
            ->with('success', 'All claimed items have been cleaned while keeping title, location, and user_id.');
    }
}
