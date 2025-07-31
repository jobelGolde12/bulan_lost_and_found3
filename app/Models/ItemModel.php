<?php

namespace App\Models;

use App\Models\Comment as ModelsComment;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class ItemModel extends Model
{
    use SoftDeletes;
        protected $table = 'items';
    protected $fillable = [
        'user_id',
        'title',
        'description',
        'category',
        'status',
        'location',
        'contact_info',
        'image_url',
        'category_id',
        'owner_phone_number', 
    ];

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');   
    }
    public function category(){
        return $this->belongsTo(CategoryModel::class, 'category_id', 'id');   
    }

    public function comments(){
        return $this->hasMany(ModelsComment::class, 'item_id', 'id');
    }
    public function viewLater(){
        return $this->hasMany(ViewLaterModel::class, 'item_id');
    }
}
