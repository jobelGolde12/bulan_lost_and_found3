<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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
    public function viewItemInfo($item){
        $getItem = ItemModel::with('comments')->findOrFail($item);
        $created_by = User::find($getItem?->user_id);
        $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');
        return Inertia::render('guest/item/View', [
            'item' => $getItem,
            'created_by' => $created_by,
            'profile' => $profile ?: 'NA',
            'comments' => $getItem->comments,
            'currentUser' =>  null,
        ]);
    }
}
