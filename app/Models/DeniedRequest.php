<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DeniedRequest extends Model
{
    protected $table = 'denied_request';

    protected $fillable = [
        'request_id',
        'user_id',
        'reason',
    ];
}
