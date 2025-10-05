<?php

use App\Http\Controllers\GuestController;
use App\Http\Controllers\ItemController;
use Illuminate\Support\Facades\Route;

Route::get('/guest-dashboard', [GuestController::class, 'index'])->name('guest.dashboard');
Route::get('/guest/view-item/{item}', [GuestController::class, 'viewItemInfo'])->name('viewItemInfoAsGuest');
