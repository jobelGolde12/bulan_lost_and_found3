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
    $currentUserId = Auth::id();

    // Removed and blocked users
    $removedUser = RemovePinnedMessages::where('user_id', $currentUserId)->pluck('removed_user');
    $blockedUser = BlockedMessages::where('user_id', $currentUserId)->pluck('blocked_user');

    $excludedIds = $removedUser->toArray();
    $excludedBlockedIds = $blockedUser->toArray();

    // Get all users (excluding removed/blocked)
    $users = User::whereNotIn('id', array_merge($excludedIds, $excludedBlockedIds))
        ->select(['id', 'name'])
        ->get();

    // Get all messages related to this user
    $hasMessages = MessageModel::where('receiver_id', $currentUserId)
        ->orWhere('sender_id', $currentUserId)
        ->get(['sender_id', 'receiver_id', 'created_at', 'read_at']);

    // Get users who have unread messages
    $unreadUserIds = MessageModel::where('receiver_id', $currentUserId)
        ->whereNull('read_at')
        ->pluck('sender_id')
        ->unique()
        ->toArray();

    // Separate users into two groups
    $usersWithUnread = $users->filter(fn($u) => in_array($u->id, $unreadUserIds));
    $usersWithoutUnread = $users->reject(fn($u) => in_array($u->id, $unreadUserIds));

    // Merge them so unread are at the top
    $sortedUsers = $usersWithUnread->merge($usersWithoutUnread)->values();

    // Fetch pinned users (same logic as before)
    $pinnedMessages = PinnedChatsModel::all();
    $pinnedUser = null;

    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

        $pinnedUser = User::whereNotIn('id', $excludedIds)
            ->whereNotIn('id', $excludedBlockedIds)
            ->with('userInfo')
            ->whereIn('id', $userIds)
            ->get()
            ->map(fn($user) => [
                'id' => $user->id,
                'name' => $user->name,
                'profile_pic' => $user->userInfo->profile_pic ?? null,
            ]);
    }

    return Inertia::render('Message', [
        'pinned' => $pinnedUser ?: [],
        'users' => $sortedUsers,
        'currentUserId' => $currentUserId,
        'hasMessages' => $hasMessages,
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

    public function searchV2(Request $request){
        $name = $request->input('name');
        $matchedUsers = User::where('name', 'LIKE', "%{$name}%")
        ->with('userInfo')
        ->get(['id', 'name']);
        
        return response()->json([
            'matchedUsers' => $matchedUsers,
        ], 200);
    }

       public function viewChat($id)
{
    $currentUserId = Auth::id();

    // 🧱 Removed and blocked users
    $removedUser = RemovePinnedMessages::where('user_id', $currentUserId)->pluck('removed_user');
    $blockedUser = BlockedMessages::where('user_id', $currentUserId)->pluck('blocked_user');

    $excludedIds = $removedUser->toArray();
    $excludedBlockedIds = $blockedUser->toArray();

    // ✅ Mark messages as read
    MessageModel::where('sender_id', $id)
        ->where('receiver_id', $currentUserId)
        ->whereNull('read_at')
        ->update(['read_at' => now()]);

    // 🧍 Get all users (excluding removed/blocked)
    $users = User::whereNotIn('id', array_merge($excludedIds, $excludedBlockedIds))
        ->select(['id', 'name'])
        ->get();

    // 📨 Get all messages related to this user (used by Vue)
    $hasMessages = MessageModel::where('receiver_id', $currentUserId)
        ->orWhere('sender_id', $currentUserId)
        ->get(['sender_id', 'receiver_id', 'created_at', 'read_at']);

    // 🔔 Users who still have unread messages
    $unreadUserIds = MessageModel::where('receiver_id', $currentUserId)
        ->whereNull('read_at')
        ->pluck('sender_id')
        ->unique()
        ->toArray();

    // 🧩 Separate users into two groups: unread and read
    $usersWithUnread = $users->filter(fn($u) => in_array($u->id, $unreadUserIds));
    $usersWithoutUnread = $users->reject(fn($u) => in_array($u->id, $unreadUserIds));

    $sortedUsers = $usersWithUnread->merge($usersWithoutUnread)->values();

    // 📌 Fetch pinned users (same logic as in index)
    $pinnedMessages = PinnedChatsModel::all();
    $pinnedUser = collect([]);

    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

        $pinnedUser = User::whereNotIn('id', $excludedIds)
            ->whereNotIn('id', $excludedBlockedIds)
            ->with('userInfo')
            ->whereIn('id', $userIds)
            ->get()
            ->map(fn($user) => [
                'id' => $user->id,
                'name' => $user->name,
                'profile_pic' => $user->userInfo->profile_pic ?? null,
            ]);
    }

    // 💬 Get chat conversation between current user and selected user
    $data1 = User::with('userInfo')->findOrFail($id);

    $data2 = MessageModel::where(function ($query) use ($id, $currentUserId) {
        $query->where('sender_id', $currentUserId)
              ->where('receiver_id', $id);
    })->orWhere(function ($query) use ($id, $currentUserId) {
        $query->where('sender_id', $id)
              ->where('receiver_id', $currentUserId);
    })->orderBy('created_at', 'asc')
      ->get();

    $message = [
        'data1' => $data1,
        'data2' => $data2,
    ];

    return Inertia::render('Message', [
        'pinned' => $pinnedUser,
        'users' => $sortedUsers,
        'hasMessages' => $hasMessages,
        'message' => $message,
        'currentUserId' => $currentUserId,
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
