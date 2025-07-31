<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RemovePinnedMessages extends Model
{
    protected $table = 'removed_pinned_messages';
    protected $fillable = ['user_id', 'removed_user'];
}
