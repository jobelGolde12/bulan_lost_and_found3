<?php

namespace App\Http\Controllers;

use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\User;
use App\Models\UserInfo;
use App\Models\ViewLaterModel;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class AdminDashboard extends Controller
{
    public function index(){
        return Inertia::render('admin/Dashboard');
    }
    public function item(){
        $categories = ItemCategories::all();
        //get only the specific viewLater data base sa id ni user
        $userId = Auth::id();
        $items = ItemModel::whereIn('status', ['Lost', 'Found'])
        ->with('user', 'user.userInfo:id,user_id,profile_pic')
        ->with(['viewLater' => function ($query) use ($userId) {
        $query->where('user_id', $userId);
        }])->orderBy('created_at', 'desc')->get();

            return Inertia::render('admin/Home', [
                'categories' => $categories,
                'items' => $items,
                'role' => 'admin',
        ]); 
}

    public function viewUsers(){
        $users = User::with('userInfo')->get();
        return Inertia::render('admin/users/Index', [
            'users' => $users,
        ]);
    }

    public function viewUser($id){
        // sa database true ang default value san isPhoneAllow & isEmailAllow
        $user = User::with(['userInfo', 'permission'])->findOrFail($id);
        return Inertia::render('admin/users/ViewUserInfo', [
            'user' => $user,
        ]);
    }
}
