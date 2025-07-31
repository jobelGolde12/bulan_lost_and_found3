<?php

namespace App\Http\Controllers;

use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\PendingRequest;
use App\Models\User;
use App\Models\ViewLaterModel;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DashboardController extends Controller
{
    public function index(){
        if (!Auth::check()) {
            return redirect()->route('login');
        }
        
        $categories = ItemCategories::all();
        $pendingRequestCount = PendingRequest::where('pending_status', 'pending')->count(); //Para sa admin (dashboard)

        if (Auth::check() && Auth::user()->role === 'user') { 
            
        //get only the specific viewLater data base sa id ni user
        $userId = Auth::id();
        $items = ItemModel::select('id','user_id', 'title', 'description', 'category', 'status', 'image_url', 'created_at')
        ->whereIn('status', ['Lost', 'Found'])
        ->with(['user', 'user.userInfo:id,user_id,profile_pic'])
        ->with(['viewLater' => function ($query) use ($userId) {
        $query->where('user_id', $userId);
         }])->orderBy('created_at', 'desc')->get();
        
            return Inertia::render('user/Dashboard', [
                'categories' => $categories,
                'items' => $items,
        ]); 
        }else if (Auth::check() && Auth::user()->role === 'admin') { 
            $userCount = User::count();
            $getItemAsAdmin = ItemModel::all();
            $recentLostAndFound = ItemModel::whereMonth('created_at', Carbon::now()->month)
            ->whereYear('created_at', Carbon::now()->year)
            ->orderBy('created_at', 'desc')->get();
            return Inertia::render('admin/Dashboard', [
                'categories' => $categories,
                'items' => $getItemAsAdmin,
                'pending_request_count' => $pendingRequestCount,
                'user_count' => $userCount,
                'recentLostAndFound' => $recentLostAndFound,
        ]); 
        }
    }
}
