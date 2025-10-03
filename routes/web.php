<?php

use App\Http\Controllers\AdminDashboard;
use App\Http\Controllers\AnnouncementTrashController;
use App\Http\Controllers\CommentController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\ItemController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\SettingsController;
use App\Http\Controllers\TrashController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ContactAdminController;
use App\Http\Controllers\DeniedRequestController;
use App\Http\Controllers\FindMatchController;
use App\Http\Controllers\MessageController;
use App\Http\Controllers\MyPermissionController;
use App\Http\Controllers\NotificationTrashController;
use App\Http\Controllers\PendingRequestController;
use App\Http\Controllers\StorageCleaner;
use App\Http\Controllers\TotalLostItem;
use App\Http\Controllers\UserTrashController;
use App\Http\Controllers\ViewLaterController;
use App\Http\Controllers\ViewMoreUsers;
use App\Models\User;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/my-profile', [ProfileController::class, 'index'])->name('profile');
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});
Route::get('/about-us', function(){
    return Inertia::render('AboutUs');
})->name('aboutUs');

// admin
Route::get('/report-item', [ItemController::class, 'reportItem'])->name('reportItem');
Route::post('/add-item', [ItemController::class, 'store'])->name('addItem');
Route::get('/view-item-info-as-admin/{item}', [ItemController::class, 'viewItemInfoAsAdmin'])->name('viewItemInfoAsAdmin');
Route::delete('/force-delete-item/{id}', [ItemController::class, 'forceDelete'])->name('forceDeleteItem');//Kapag d nag follow c user sa privacy & policy


//Permission
Route::prefix('mypermission')->name('myPermission.')->middleware('auth')->group(function () {
    Route::put('/modify-phone-permission', [MyPermissionController::class, 'togglePhonePermission'])->name('togglePhonePermission');
    Route::put('/modify-email-permission', [MyPermissionController::class, 'toggleEmailPermission'])->name('toggleEmailPermission');
});
//resolve cases
Route::post('/mark-as-resolve/{id}/{userId}', [ItemController::class, 'markAsResolve'])->name('markAsResolve');
Route::get('get-owner-profile/{id}', [ItemController::class, 'getOwnerProfile'])->name('getOwnerProfile');



//Para sa route na related lang sa settings (diri sa trash)
Route::prefix('settings')->name('settings.')->group(function () {
    Route::get('/view-settings', [SettingsController::class, 'index'])->name('index');
    Route::get('/notifications', [SettingsController::class, 'notifications'])->name('notifications');
    Route::get('/announcements', [SettingsController::class, 'announcements'])->name('announcements');
    Route::get('/add-announcement-page', [SettingsController::class , 'addAnnouncementPage'])->name('addAnnouncementPage');
    Route::post('/add-announcements', [SettingsController::class, 'addAnnouncement'])->name('announcements.store');
    Route::delete('/delete-announcement/{id}', [SettingsController::class, 'deleteAnnouncement'])->name('announcement.destroy');
    Route::delete('/delete-notification/{id}', [SettingsController::class, 'deleteNotification'])->name('deleteNotification');// post para maka create trash notification
    Route::get('/privacy', [SettingsController::class, 'privacy'])->name('privacy');
    Route::put('/modify-read-status/{notification}', [SettingsController::class, 'modifyReadStatus'])->name('modifyReadStatus');
});


//Para lang sa trash 
Route::prefix('/trash')->name('trash.')->group(function () {
    Route::get('/view-trash', [TrashController::class, 'index'])->name('index');
    Route::get('/trash-item', [TrashController::class, 'trashItemRoute'])->name('trashItemRoute');
    Route::delete('/delete-item-trash/{id}', [TrashController::class, 'deleteItemTrash'])->name('deleteItem');
    Route::post('/restore-item/{id}', [TrashController::class, 'restore'])->name('restore');
});
Route::get('/view-trash-item/{id}', [TrashController::class, 'viewTrashItem'])->name('viewTrashItem');//view the specific trash item


Route::prefix('announcementTrashed')->name('announcementTrashed.')->middleware('auth')->group(function (){
    Route::get('/view-trash-announcement', [AnnouncementTrashController::class, 'index'])->name('index');
    Route::put('/restore-announcement/{id}', [AnnouncementTrashController::class, 'restore'])->name('restore');
    Route::delete('/delete-announcement/{id}', [AnnouncementTrashController::class, 'delete'])->name('delete');
});


Route::prefix('notificationTrashed')->name('notificationTrashed.')->middleware('auth')->group(function (){
    Route::get('/view-trash-announcement', [NotificationTrashController::class, 'index'])->name('index');
    Route::put('/restore-announcement/{id}', [NotificationTrashController::class, 'restore'])->name('restore');
    Route::delete('/delete-announcement/{id}', [NotificationTrashController::class, 'delete'])->name('delete');
});

// mga na trash na user
Route::prefix('userTrashed')->name('userTrashed.')->middleware('auth')->group(function (){
    Route::get('trashed-users', [UserTrashController::class, 'index'])->name('index');
    Route::get('/view-trashed-user-info/{id}', [UserTrashController::class, 'view'])->name('view'); //specific user
    Route::put('/restore-deleted-user/{id}', [UserTrashController::class, 'restore'])->name('restore');
    Route::delete('/delete-user/{id}', [UserTrashController::class, 'delete'])->name('delete');
    Route::delete('/delete-user-permanently/{id}', [UserTrashController::class, 'deletePermanently'])->name('deletePermanently');
});


Route::prefix('viewLater')->name('viewLater.')->middleware('auth')->group(function (){
    Route::post('/add-view-later/{id}', [ViewLaterController::class, 'add'])->name('add');
    Route::get('/view-my-saved-items', [ViewLaterController::class, 'viewWatchLater'])->name('view');
});

Route::delete('/admin/item/trash/{id}', [TrashController::class, 'trashItem'])->name('trashItem');
Route::post('/admin/item/restore/{id}', [TrashController::class, 'restore'])->name('restoreItem');
Route::delete('/admin/item/destroy/{id}', [TrashController::class, 'destroy'])->name('destroyItem');

//Users trashed
Route::delete('/delete-user/{id}', [SettingsController::class, 'deleteUser'])->name('user.delete');
Route::get('/view-item-info/{item}', [ItemController::class, 'viewItemInfo'])->name('viewItemInfo');
Route::get('/view-item/{item}', [ItemController::class, 'viewItem'])->name('viewItem');
Route::delete('delete-item/{id}', [ItemController::class, 'deleteItem'])->name('deleteItem');
Route::get('/items', [AdminDashboard::class, 'item'])->name('items');
Route::get('/admin-dashboard', [AdminDashboard::class, 'index'])->name('adminDashboard');


Route::get('/total-lost-item', [TotalLostItem::class, 'index'])->name('totalLostItemIndex');
Route::get('/view-lost-item/{id}', [TotalLostItem::class, 'view'])->name('viewLostItem'); //view the specific lost item
Route::get('/contact-admin', [ContactAdminController::class, 'index'])->name('contactAdmin');
Route::post('/submit-contact', [ContactAdminController::class, 'sendMessage'])->name('sendMessage');

//pending request
Route::get('/view-pending-request', [PendingRequestController::class, 'index'])->name('viewPendingRequest');
Route::post('/approve-request/{item}', [PendingRequestController::class, 'approveRequest'])->name('approverequest');
Route::get('/view-pending/{item}', [PendingRequestController::class, 'viewPending'])->name('view.pending');
Route::get('/deny-request-view/{item}', [PendingRequestController::class, 'denyRequestView'])->name('deny.request.view');
Route::delete('/deny-request/{item}', [PendingRequestController::class, 'denyRequest'])->name('deny.request');
Route::post('/face-to-face/{item}', [PendingRequestController::class, 'faceTofaceVerification'])->name('f2f.verification');

//comment
Route::post('/add-comment', [CommentController::class, 'store'])->name('comment.store');
Route::delete('/delete-comment/{id}', [CommentController::class, 'delete'])->name('comment.delete');

//profile
Route::put('/user-update/{id}', [ProfileController::class, 'userUpdate'])->name('user.update');
Route::post('/user-update-post/{id}', [ProfileController::class, 'userUpdatePost'])->name('user.update.post'); //amo an ginamit

//Privacy (sa signup page)
Route::get('/view-privacy', function(){
    return Inertia::render('PrivacyInSignup');
})->name('view.privacy');


// view users (para sa admin)
Route::get('/view-users', [AdminDashboard::class, 'viewUsers'])->name('view.users');
Route::get('/view-user-info-as-admin/{id}', [AdminDashboard::class, 'viewUser'])->name('viewUserAsAdmin'); //specific user
Route::delete('/delete-users/{id}', [TrashController::class, 'userDestroy'])->name('user.destroy');

//message
Route::get('/message', [MessageController::class, 'index'])->name('message.index');
Route::get('/message-search/{id}', [MessageController::class, 'search'])->name('message.search');
Route::get('/message-view-chat/{id}', [MessageController::class, 'viewChat'])->name('message.viewChat');
Route::post('/messages/send', [MessageController::class, 'send'])->middleware('auth');
Route::post('/remove-message/{id}', [MessageController::class, 'remove'])->name('message.remove');
Route::post('/block-message/{id}', [MessageController::class, 'block'])->name('message.block');

// View more users (saro na route na ma iimud sa messages page) || iba ini sa view.users san admin
Route::prefix('viewMoreUsers')->name('viewMoreUsers.')->middleware('auth')->group(function () {
    Route::get('/view-all-the-users', [ViewMoreUsers::class, 'index'])->name('index');
    Route::delete('/unblock-user/{id}', [ViewMoreUsers::class, 'unBlock'])->name('unBlock');
    Route::get('/view-all-blocked-users', [ViewMoreUsers::class, 'viewAllBlocked'])->name('blocked');
});

//view user para sa user (diri admin)
Route::get('/view-user-info/{id}', [UserController::class, 'viewUser'])->name('view.userAsUser'); //specific user
Route::get('/my-pending-requests', [UserController::class, 'myPendingRequests'])->name('my.pending'); //specific user
Route::get('/face-to-face/{id}', [UserController::class, 'faceToFace'])->name('face.to.face'); //specific user

Route::prefix('deniedRequests')->name('deniedRequests.')->middleware('auth')->group(function (){
    Route::get('/view-denied-requests/{itemId}', [DeniedRequestController::class, 'index'])->name('index');
});

Route::post('/storage-cleaner/delete-claimed', [StorageCleaner::class, 'deleteClaimed'])
    ->name('storage-cleaner.delete-claimed');

//Find Match
Route::get('/find-match', [FindMatchController::class, 'index'])->name('findMatch.index');
require __DIR__.'/auth.php';

