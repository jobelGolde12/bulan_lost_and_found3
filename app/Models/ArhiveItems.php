<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ArhiveItems extends Model
{
    protected $table = 'archived_items';
    protected $fillable = [
        'original_id',
        'archived_data'
    ];
}
