<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class NotificationModel extends Model
{
    use SoftDeletes;
    protected $table = 'notifications';
    protected $fillable = [
        'title',
        'user_id',
        'message',
        'read_status',
    ];
}
