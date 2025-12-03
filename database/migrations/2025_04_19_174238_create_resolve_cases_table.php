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
        Schema::create('resolve_cases', function (Blueprint $table) {
            $table->id();
            $table->string('item_id');
            // $table->foreignId('admin_id')->constrained('users')->onDelete('cascade'); // assuming 'users' table for admins
            $table->enum('resolution_status', ['Claimed', 'Returned', 'Other'])->default('Claimed');
            $table->unsignedBigInteger('user_id')->index();
            $table->string('title')->nullable();
            $table->text('description')->nullable();
            $table->string('category')->nullable();
            $table->string('location')->nullable();
            $table->enum('status', ['Lost', 'Found', 'Claimed']);
            $table->string('contact_info')->nullable();
            $table->string('image_url')->nullable();
            $table->timestamps(); 
            $table->unsignedBigInteger('category_id')->nullable()->index();
            $table->string('owner_phone_number')->nullable();
            $table->timestamp('resolved_at')->useCurrent();  
        });
    }

    /**
     * Reverse the migrations.a
     */
    public function down(): void
    {
        Schema::dropIfExists('resolve_cases');
    }
};