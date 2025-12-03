<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use App\Models\UserInfo;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Authenticatable implements MustVerifyEmail
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, SoftDeletes;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function userInfo(){
        return $this->hasOne(UserInfo::class , 'user_id', 'id');
    }
    public function trashNotification(){
        return $this->hasMany(TrashNotificationModel::class, 'user_id');
    }
    public function canInteractWithReceiver($receiverId)
    {
        return true; 
    }
    public function removedPinnedMessage(){
        return $this->hasMany(RemovePinnedMessages::class , 'user_id');
    }
    public function blockedMessage(){
        return $this->hasMany(BlockedMessages::class, 'user_id');
    }
    public function permission(){
        return $this->hasOne(MyPermissionModel::class, 'user_id');
    }
    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }
}
