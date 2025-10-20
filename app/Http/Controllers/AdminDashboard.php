<?php

namespace App\Http\Controllers;

use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\LocationModel;
use App\Models\MessageModel;
use App\Models\TargetResolvedCases;
use App\Models\TotalLost;
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

        $locations = LocationModel::select('id','name')->get();

            return Inertia::render('admin/Home', [
                'categories' => $categories,
                'items' => $items,
                'role' => 'admin',
                'locations' => $locations,
        ]); 
}
    public function filterByLocation($id){

        $currentLocation = LocationModel::findOrFail($id);

        $categories = ItemCategories::all();
        //get only the specific viewLater data base sa id ni user
        $userId = Auth::id();
        $items = ItemModel::whereIn('status', ['Lost', 'Found'])
        ->where('location', $currentLocation->name)
        ->with('user', 'user.userInfo:id,user_id,profile_pic')
        ->with(['viewLater' => function ($query) use ($userId) {
        $query->where('user_id', $userId);
        }])->orderBy('created_at', 'desc')->get();

        $locations = LocationModel::select('id','name')->get();

            return Inertia::render('admin/Home', [
                'categories' => $categories,
                'items' => $items,
                'role' => 'admin',
                'locations' => $locations,
                'currentLocation' => $currentLocation->name,
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
    public function hasMessage(){
        $currentUserId = Auth::id();
        $hasMessages = MessageModel::where(function ($query) use ($currentUserId) {
        $query->where('sender_id', '!=', $currentUserId)
              ->whereNull('read_at');
    })
    //  ensure uniqueness: count unique sender_id or receiver_id pairs
    ->selectRaw('DISTINCT sender_id')
    ->get()
    ->count();
        return response()->json($hasMessages);
    }

    public function targetResolveCases($target, $type){
        $currentTarget = TargetResolvedCases::select(['id','target_value'])->first();
        
        if($type == 'increase'){
            $target = $target + 100;
        }else{
            $target = $target - 100;
        }
        
        $currentTarget->update([
            'target_value' => $target
        ]);

        return response()->json($currentTarget->target_value);
    }
    public function getTargetResolveCases(){
        $currentTarget = TargetResolvedCases::select(['id','target_value'])->first();
        return response()->json($currentTarget->target_value);
    }

    public function getItems(Request $request)
    {
        $status = $request->query('status');
        $query = ItemModel::query();

        if ($status) {
        if ($status === 'Unsolved') {
            $query->whereDate('created_at', '<=', now()->subYear());
        } elseif ($status === 'Resolved') {
            $query->where('status', 'Claimed');
        } else {
            $query->where('status', $status);
        }
    }

        $items = $query->orderBy('created_at', 'desc')->paginate(15);

        return response()->json($items);
    }
}
