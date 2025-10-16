<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TotalLost extends Model
{
    protected $table = 'total_lost';

    protected $fillable = [
        'total',
    ];


}
