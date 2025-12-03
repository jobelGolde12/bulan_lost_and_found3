<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MyPermissionModel extends Model
{
    protected $table = 'my_permission';
    protected $fillable = ['user_id', 'isPhoneAllow', 'isEmailAllow'];
}
