<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ItemModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class UserPostController extends Controller
{
    public function index(){
    $items = ItemModel::where('user_id', Auth::id())
    ->orderBy('created_at', 'desc')
    ->get();
    return Inertia::render('user/Posts', [
        'items' => $items,
    ]);

    }
}
