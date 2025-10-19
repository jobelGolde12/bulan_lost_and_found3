<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TargetResolvedCases extends Model
{
    protected $table = 'target_resolved_cases';
    protected $fillable = ['target_value'];
}
