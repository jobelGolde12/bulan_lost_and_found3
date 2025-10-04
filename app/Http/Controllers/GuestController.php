<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ItemCategories;
use App\Models\ItemModel;
use Illuminate\Http\Request;
use Inertia\Inertia;

class GuestController extends Controller
{
    public function index(){
        $items = ItemModel::select('id','user_id', 'title', 'description', 'category', 'status', 'image_url', 'created_at')
        ->whereIn('status', ['Lost', 'Found'])
        ->with(['user', 'user.userInfo:id,user_id,profile_pic'])
        ->orderBy('created_at', 'desc')->get();
        $categories = ItemCategories::all();
        
            return Inertia::render('guest/Dashboard', [
                'categories' => $categories,
                'items' => $items,
        ]); 
    }
}
