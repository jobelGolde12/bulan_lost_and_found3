<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::create('pending_requests', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id')->index();
            $table->string('title', 255)->nullable();
            $table->text('description')->nullable();
            $table->string('category', 255)->nullable();
            $table->string('location', 255)->nullable();
            $table->enum('status', ['Lost', 'Found', 'Claimed'])->default('Lost');
            $table->string('contact_info', 255)->nullable();
            $table->string('image_url', 255)->nullable();
            $table->timestamp('reported_at')->useCurrent();
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrent()->useCurrentOnUpdate();
            $table->unsignedBigInteger('category_id')->nullable()->index();
            $table->string('owner_phone_number', 255)->nullable();
            $table->enum('pending_status', ['pending', 'approve'])->default('pending');
        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pending_request');
    }
};
