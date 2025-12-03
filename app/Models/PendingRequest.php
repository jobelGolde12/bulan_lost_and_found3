<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PendingRequest extends Model
{
    protected $table = 'pending_requests';
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
        'pending_status',
    ];

    public function user(){
        return $this->belongsTo(User::class, 'user_id', 'id');   
    }
    public function category(){
        return $this->belongsTo(CategoryModel::class, 'category_id', 'id');   
    }
}
