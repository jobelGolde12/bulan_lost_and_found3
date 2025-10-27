<?php

namespace App\Models;

use App\Models\ItemModel as ModelsItemModel;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Comment extends Model
{
    protected $table = "comments";
    protected $fillable = [
        'user_id',
        'item_id',
        'content',
    ];

    public function item(){
        return $this->BelongsTo(ModelsItemModel::class);
    }
    public function user(){
        return $this->BelongsTo(User::class);
    }
    // To get the profile pic of user 
    public function userInfo(){
        return $this->belongsTo(UserInfo::class, 'user_id');
    }
}
