<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\User;
use Illuminate\Database\Eloquent\SoftDeletes;

class AnnouncementModel extends Model
{
    use SoftDeletes;
    protected $table = 'announcements';
    protected $fillable = [
        'user_id',
        'title',
        'content'
    ];

    public function user(){
        return $this->hasOne(User::class, 'id', 'user_id');
    }
    public function userProfile(){
        return $this->hasOne(UserInfo::class, 'id', 'user_id');
    }
}
