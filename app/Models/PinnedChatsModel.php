<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PinnedChatsModel extends Model
{
    protected $table = 'pinned_chats';
    protected $fillable = [
        'user_id',
        'message_id'
    ];
}
