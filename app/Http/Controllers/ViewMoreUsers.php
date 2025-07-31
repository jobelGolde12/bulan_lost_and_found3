<?php

namespace App\Http\Controllers;

use App\Models\BlockedMessages;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ViewMoreUsers extends Controller
{
    //Ang route sadi ma iimud sa Message (PopupForMessage component)
    // Iba ini sa view users san admin, diu lang ang credentials na naka latag
    public function index(){
        $blockedUser = BlockedMessages::where('user_id', Auth::id())->get(['id', 'blocked_user']);
        $excludedBlockedIds = $blockedUser->pluck('blocked_user')->toArray();
        $users = User::with('userInfo')->with('blockedMessage')->get();
        return Inertia::render('ViewMoreUsers', [
            'users' => $users,
            'blocked_users' => $excludedBlockedIds,
            'toggleStatus' => 'all' //Para sa ToggleAllOrBlocked component
        ]);
    }
    public function unBlock($id){
        $blockedUser = BlockedMessages::where('blocked_user', $id)->firstOrFail();
        $blockedUser->delete();
        return redirect()->back()->with(['success' => 'user unblocked']);
        
    }
    public function viewAllBlocked(){
       $blockedUsers = BlockedMessages::where('user_id', Auth::id())
    ->get(['id', 'blocked_user']);

    $excludedBlockedIds = $blockedUsers->pluck('blocked_user')->toArray();

    $users = User::with(['userInfo', 'blockedMessage'])
        ->whereIn('id', $excludedBlockedIds) 
        ->get();

    return Inertia::render('ViewMoreUsers', [
        'users' => $users,
        'blocked_users' => $excludedBlockedIds,
        'toggleStatus' => 'blocked'
    ]);



}
}