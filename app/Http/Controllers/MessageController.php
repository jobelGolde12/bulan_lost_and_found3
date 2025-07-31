<?php

namespace App\Http\Controllers;
use App\Events\NewMessageSent;
use App\Models\BlockedMessages;
use App\Models\MessageModel;
use App\Models\PinnedChatsModel;
use App\Models\RemovePinnedMessages;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class MessageController extends Controller
{
    public function index()
{
    //para ma view sa search
    $currentUserId = Auth::id();
    $removedUser = RemovePinnedMessages::where('user_id', $currentUserId)->get(['id', 'removed_user']);
    $blockedUser = BlockedMessages::where('user_id', $currentUserId)->get(['id', 'blocked_user']);
    $excludedIds = $removedUser->pluck('removed_user')->toArray(); // para sa removed
    $excludedBlockedIds = $blockedUser->pluck('blocked_user')->toArray();
    if (empty($excludedIds)) {
    $users = User::select(['id', 'name'])->get();
    } else {
        $users = User::whereNotIn('id', $excludedIds)
            ->select(['id', 'name'])
            ->get();
    }



    $pinnedMessages = PinnedChatsModel::all();

    $pinnedUser = null;
    $data1 = null;
     $data2 = null;

    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

        //Pinned user sabay ang info para ma kuha ang profile 
        if (empty($excludedIds)) { //But first d muna eh include ang in remove ni user
             $pinnedUser = User::with('userInfo')
            ->whereIn('id', $userIds)
            ->get()
            ->map(function ($user) {
                return [
                    'id' => $user->id,
                    'name' => $user->name,
                    'profile_pic' => $user->userInfo->profile_pic ?? null,
                ];
            });
        }else{
             $pinnedUser = User::whereNotIn('id', $excludedIds)
             ->whereNotIn('id', $excludedBlockedIds)
             ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }

        // Para namn sa blocked user d dapat eh include sa pinned user 
        // Hiwalay ang logic para sa removed and block kay mag bug
        if (!empty($excludedBlockedIds)) {
             $pinnedUser = User::whereNotIn('id', $excludedIds)
             ->whereNotIn('id', $excludedBlockedIds)
             ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }

    }
        // =====================================

    $message = [
        'data1' => $data1,
        'data2' => $data2,
    ];
    return Inertia::render('Message', [
        'pinned' => $pinnedUser ?: [],
        'message' => $message ?: null,
        'users' => $users,
        'currentUserId' => Auth::id(),
    ]);
}


    public function send(Request $request)
    {
        $validatedData = $request->validate([
            'receiver_id' => 'required|exists:users,id',
            'content' => 'required|string|max:1000',
        ]);

        // Create a new message
        $message = MessageModel::create([
            'sender_id' => Auth::id(),
            'receiver_id' => $validatedData['receiver_id'],
            'message' => $validatedData['content'],
        ]);

        // Broadcast the message
        broadcast(new NewMessageSent(
            $message->sender_id,
            $message->receiver_id,
            $message->message,
            $message->created_at
        ));

        return response()->json($message, 201);
    }


public function search($id)
{
    $user = User::find($id);
    $message = MessageModel::where('sender_id', $id)->get();
    //para ma view sa search
    $currentUserId = Auth::id();
    $users = User::whereDoesntHave('removedPinnedMessage', function($query) use ($currentUserId) {
    $query->where('user_id', $currentUserId)
          ->whereColumn('removed_user', 'users.id');
})
->get(['id', 'name']);

    if (!$user) {
        return response()->json(['message' => 'cannot find user'], 404);
    }

    $duplicatePinned = PinnedChatsModel::where('user_id', $id)->first();

    if (!$duplicatePinned) {
        PinnedChatsModel::create([
            'user_id' => $id,
            'message_id' => optional($message->first())->id ?: null,
        ]);
    }


    $pinnedMessages = PinnedChatsModel::all();

    $pinnedUser = null;

    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

        $pinnedUser = User::with('userInfo')
            ->whereIn('id', $userIds)
            ->get()
            ->map(function ($user) {
                return [
                    'id' => $user->id,
                    'name' => $user->name,
                    'profile_pic' => $user->userInfo->profile_pic ?? null,
                ];
            });
    }

    return to_route('message.viewChat', ['id' => $id]);
}

        public function viewChat($id)
{
    $pinnedMessages = PinnedChatsModel::all();
    $pinnedUser = null;

    $currentUserId = Auth::id();
    $removedUser = RemovePinnedMessages::where('user_id', $currentUserId)->get(['id', 'removed_user']);
    $blockedUser = BlockedMessages::where('user_id', $currentUserId)->get(['id', 'blocked_user']);
    $excludedIds = $removedUser->pluck('removed_user')->toArray(); // para sa removed
    $excludedBlockedIds = $blockedUser->pluck('blocked_user')->toArray();

    if (empty($excludedIds)) {
    $users = User::select(['id', 'name'])->get();
    } else {
        $users = User::whereNotIn('id', $excludedIds)
            ->select(['id', 'name'])
            ->get();
    }

    // Retrieve pinned messages and their associated user information
    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

         //Pinned user sabay ang info para ma kuha ang profile 
        if (empty($excludedIds)) { //But first d muna eh include ang in remove ni user
             $pinnedUser = User::with('userInfo')
            ->whereIn('id', $userIds)
            ->get()
            ->map(function ($user) {
                return [
                    'id' => $user->id,
                    'name' => $user->name,
                    'profile_pic' => $user->userInfo->profile_pic ?? null,
                ];
            });
        }else{
             $pinnedUser = User::whereNotIn('id', $excludedIds)
             ->whereNotIn('id', $excludedBlockedIds)
             ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }

        // Para namn sa blocked user d dapat eh include sa pinned user 
        // Hiwalay ang logic para sa removed and block kay mag bug
        if (!empty($excludedBlockedIds)) {
             $pinnedUser = User::whereNotIn('id', $excludedIds)
             ->whereNotIn('id', $excludedBlockedIds)
             ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }

    }

    $data1 = User::with('userInfo')->find($id);

    $data2 = MessageModel::where(function ($query) use ($id) {
        $query->where('sender_id', Auth::id())
              ->where('receiver_id', $id);
    })->orWhere(function ($query) use ($id) {
        $query->where('sender_id', $id)
              ->where('receiver_id', Auth::id());
    })->orderBy('created_at', 'asc') // Ensure messages are in chronological order
      ->get();

    $message = [
        'data1' => $data1, // Selected user's information
        'data2' => $data2, // Conversation messages
    ];

    return Inertia::render('Message', [
        'pinned' => $pinnedUser,
        'message' => $message ?: null,
        'users' => $users,
        'currentUserId' => Auth::id(),
    ]);
}

public function remove($id){
    if(!$id){
        return redirect()->back()->with(['error' => 'cannot find user']);
    }
    RemovePinnedMessages::create([
        'user_id' => Auth::id(),
        'removed_user' => $id,
    ]);
      return redirect()->back()->with(['success' => 'user removed']);
}

public function block($id){
    if(!$id){
        return redirect()->back()->with(['error' => 'cannot find user']);
    }
        BlockedMessages::create([
            'user_id' => Auth::id(),
            'blocked_user' => $id,
        ]);
      return redirect()->back()->with(['success' => 'user blocked']);
}
}
