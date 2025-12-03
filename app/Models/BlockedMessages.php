<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BlockedMessages extends Model
{
    protected $table = 'blocked_messages';
    protected $fillable = ['user_id', 'blocked_user'];
    
}
