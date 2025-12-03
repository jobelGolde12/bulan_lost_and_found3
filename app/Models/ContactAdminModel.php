<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ContactAdminModel extends Model
{
    use HasFactory;

    protected $table = 'contact_admin';

    protected $fillable = [
        'name',
        'email',
        'message',
    ];
}
