<?php

use App\Http\Controllers\GuestController;
use Illuminate\Support\Facades\Route;

Route::get('/guest-dashboard', [GuestController::class, 'index'])->name('guest.dashboard');