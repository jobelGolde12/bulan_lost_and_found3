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
}
