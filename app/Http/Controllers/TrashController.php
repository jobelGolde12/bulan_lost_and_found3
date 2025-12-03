<?php

namespace App\Http\Controllers;

use App\Models\AnnouncementModel;
use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\NotificationModel;
use App\Models\TrashModel;
use App\Models\TrashUser;
use App\Models\TrashUserInfo;
use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class TrashController extends Controller
{
    // Show all trashed items
    public function index()
    {
        if(Auth::user()->role == 'admin'){
            $trashedItems = ItemModel::where('user_id', Auth::id())->onlyTrashed()->get(); 
             $hasUnread = NotificationModel::where('user_id', Auth::id())->where('read_status', 0)->exists();   
            return Inertia::render('Settings/admin/ItemTrash', [
                'items' => $trashedItems,
                'hasUnread' => $hasUnread,
            ]);
        }else{
            $notifications = NotificationModel::where('user_id', Auth::id())->onlyTrashed()->get();
             $hasUnread = NotificationModel::where('user_id', Auth::id())->where('read_status', 0)->exists();   
            return Inertia::render('Settings/user/NotificationTrashed', [
                'notifications' => $notifications,
                'hasUnread' => $hasUnread,
            ]);
        }
    }

    public function trashItem($id)
    {
        $item = ItemModel::find($id);
        if (!$item) {
            return back()->with('error', 'Item not found.');
        }

        $item->delete();
        $categories = ItemCategories::all();
        $items = ItemModel::with('user:id,name', 'category:name,description')->get();
        return Inertia::render('admin/Home', [
          'categories' => $categories,
          'items' => $items,
        ]);
    }

    // Restore item from trash
    public function restore($id)
    {
        $trashedItem = ItemModel::onlyTrashed()->find($id);
        if (!$trashedItem) {
            return response()->json(['Message' => 'Cannot find item'], 404);
        }
    
        $trashedItem->restore();
    
        return redirect()->back()->with('success', 'Item restored successfully.');
    }

    // Permanently delete item
    public function destroy($id)
    {
        $trashedItem = ItemModel::onlyTrashed()->find($id);

        if (!$trashedItem) {
            return back()->with('error', 'Item not found.');
        }

        $trashedItem->forceDelete(); 
        return back()->with('success', 'Item permanently deleted.');
    }

    public function trashItemRoute(){
        $items = ItemModel::onlyTrashed()->get();
        return Inertia::render('Settings/admin/ItemTrash' , [
            'items' => $items,
        ]);
    }

   
    public function userDestroy($id){
        $user = User::with('userInfo')->findOrFail($id);
        $getUserInfo = UserInfo::where('user_id' , $id);

        TrashUser::create([
            'id' => $user->id,
            'name' => $user->name,
            'email' => $user->email,
            'password' => $user->password,
            'role' => $user->role,
            'email_verified_at' => $user->email_verified_at ?: null,
        ]);
       
            TrashUserInfo::created([
                'user_id' => $user->UserInfo->user_id,
                'profile_pic' => $user->UserInfo->profile_pic,
                'address' => $user->UserInfo->address ?: null,
                'bio' => $user->UserInfo->bio ?: null,
                'contact' => $user->UserInfo->contact ?: null,
                'facebook_links' => $user->UserInfo->facebook_links ?: null,
            ]);
        $getUserInfo->delete();     
        $user->delete();
        $user = User::with('userInfo')->findOrFail($id);
        return Inertia::render('admin/users/ViewUserInfo', [
            'user' => $user,
        ]);
    }

    public function viewTrashItem($id){
        $trashedItem = ItemModel::onlyTrashed()->find($id);
        
        
       if(Auth::user()->role == 'admin'){
        return Inertia::render('Settings/admin/ViewTrashItem', [
            'trashedItem' => $trashedItem, 
        ]);
       }else{
        return Inertia::render('Settings/user/ViewTrashItem', [
            'trashedItem' => $trashedItem, 
        ]);
       }
    }

    public function deleteItemTrash($id){
        $item = ItemModel::withTrashed()->findOrFail($id);

        $item->forceDelete();
        return redirect()->back()->with(['message' => 'item deleted.']);
    }
}
