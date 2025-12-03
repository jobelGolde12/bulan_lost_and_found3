<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;
class TrashNotificationModel extends Model
{
    protected $table = 'trash_notifications';
    protected $fillable = [
        'title',
        'user_id',
        'message',
        'read_status',
    ];

    public function user(){
        return $this->belongsTo(User::class);
    }
}
