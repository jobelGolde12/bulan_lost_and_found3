<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('my_permission', function (Blueprint $table) {
            $table->id();
            $table->integer('user_id');//Na set as FK sa database
            $table->boolean('isPhoneAllow'); // na palitan san defaul value 
            $table->boolean('isEmailAllow');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('my_permission');
    }
};
