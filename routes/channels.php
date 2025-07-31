<?php

use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Log;

//ang $user (currently authenticated user)
// $receiverId (Represents the {receiverId} placeholder in the channel name (e.g., chat.{receiverId}).)
Broadcast::channel('chat.{receiverId}', function ($user, $receiverId) {
    Log::info(['auth_user' => $user->id, 'receiver_id' => $receiverId]);
    return (int) $user->id === (int) $receiverId;
});

Broadcast::routes(['middleware' => ['web', 'auth']]);