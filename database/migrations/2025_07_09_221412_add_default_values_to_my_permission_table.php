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
        Schema::table('my_permission', function (Blueprint $table) {
            $table->boolean('isPhoneAllow')->default(true)->change();
            $table->boolean('isEmailAllow')->default(true)->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('my_permission', function (Blueprint $table) {
            $table->boolean('isPhoneAllow')->default(null)->change();
            $table->boolean('isEmailAllow')->default(null)->change();
        });
    }
};
