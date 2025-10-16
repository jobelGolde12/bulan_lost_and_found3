<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TotalFound extends Model
{
      protected $table = 'total_found';

    protected $fillable = [
        'total',
    ];
}
