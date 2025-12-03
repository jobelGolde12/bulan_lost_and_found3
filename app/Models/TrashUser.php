<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrashUser extends Model
{
    protected $table = 'trash_users';
    protected $fillable = [
        // 'user_id',
        'name',
        'email',
        'password',
        'email_verified_at',
        'password',
        'role',
    ];
}
