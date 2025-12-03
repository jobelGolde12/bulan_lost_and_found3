<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\ItemModel;
use App\Models\User;

class TotalLostItem extends Controller
{
    public function index()
    {
        $lostItems = ItemModel::where('status', 'Lost')->get();

        return Inertia::render('admin/TotalLostItem', [
            'items' => $lostItems
        ]);
    }
    public function view($id){
        $item = ItemModel::findOrFail($id);
        $name = User::where('id', $item->user_id)->pluck('name')->first();
        return Inertia::render('admin/ViewLostItem',[
            'item' => $item,
            'created_by' => $name,
        ]);
    }
}
