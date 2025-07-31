<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ViewLaterModel extends Model
{
    use SoftDeletes;
    protected $table = 'view_later';
    protected $fillable = [
        'user_id',
        'item_id',
    ];
    
}
