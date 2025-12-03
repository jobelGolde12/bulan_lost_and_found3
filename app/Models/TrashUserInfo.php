<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrashUserInfo extends Model
{
    protected $table = 'trash_users_info';
    protected $fillable = [
        'id',
        'user_id',
        'profile_pic',
        'address',
        'bio',
        'contact',
        'facebook_links',
    ];
}
