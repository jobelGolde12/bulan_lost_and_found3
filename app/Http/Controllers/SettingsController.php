<?php

namespace App\Http\Controllers;

use App\Models\AnnouncementModel;
use App\Models\ItemModel;
use App\Models\NotificationModel;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\TrashModel;
use App\Models\TrashUser;
use App\Models\TrashUserInfo;
use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Support\Facades\Log;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;

class SettingsController extends Controller
{
    use SoftDeletes;
    public function index()
    {
        if(Auth::check() && Auth::user()->role === 'admin'){
           $trashedItems = ItemModel::where('user_id', Auth::id())->onlyTrashed()->get();  
            return Inertia::render('Settings/admin/ItemTrash', [
                'items' => $trashedItems,
            ]);
        }else{
            $notifications = NotificationModel::where('user_id', Auth::id())->get();
             $hasUnread = NotificationModel::where('user_id', Auth::id())->where('read_status', 0)->exists();   
            return Inertia::render('Settings/user/Main', [
            'notifications' => $notifications,
            'hasUnread' => $hasUnread,
            ]);
        }
    }

    // sa user pakadto padin ang route sa notification 
    // since mao ang default na route niya
    public function notifications()
    {
        $notification = NotificationModel::where("user_id", Auth::id())->get();
      $hasUnread = NotificationModel::where('user_id', Auth::id())->where('read_status', 0)->exists();   
        if(Auth::user()->role == 'admin'){
            return Inertia::render('Settings/admin/Notifications', [
                'notification' => $notification,
                'hasUnread' => $hasUnread,
            ]);
        }else{
            return Inertia::render('Settings/user/Notifications', [
                'notifications' => $notification,
                'hasUnread' => $hasUnread
            ]);
        }
    }

    public function announcements()
    {
        $ann = AnnouncementModel::with(['user:id,name,role', 'userProfile:id,profile_pic'])->get();
        if(Auth::user()->role == 'admin'){
            return Inertia::render('Settings/admin/Announcement', [
                'ann' => $ann,
            ]);
        }else{
            return Inertia::render('Settings/user/Announcement', [
                'ann' => $ann,
            ]);
        }
    }

    public function addAnnouncementPage(){
        return Inertia::render('Settings/admin/CreateAnnouncement');
    }

     public function addAnnouncement(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ]);

        AnnouncementModel::create([
            'user_id' => Auth::id(),
            'title' => $validated['title'],
            'content' => $validated['content'],
        ]);

        return redirect()->back()->with('success', 'Announcement created successfully!');
    }

    public function deleteAnnouncement($id){
        $ann = AnnouncementModel::where('user_id', Auth::id())->where('id', $id)->first();
        if(!$ann){
            return response()->json(['message' => 'cannot find announcement']);
        }
        $ann->delete();
    }

    public function privacy()
    {
        return Inertia::render('Privacy', [
            'title' => 'Privacy Settings',
        ]);
    }

    public function deleteNotification($id){
       $notification = NotificationModel::findOrFail($id);

        $notification->delete();
      

       return redirect()->back()->with(['message' => 'notification deleted']);
    }

    public function modifyReadStatus($notification){
        $data = NotificationModel::find($notification);
        if (!$data) {
            return response()->json(['message' => 'Notification not found.'], 404);
        }
        $data->update([
            'read_status' => 1
        ]);
        return redirect()->back()->with(['message' => 'status changed.']);
    }

    public function deleteUser($id){
        $user = TrashUser::find($id);
        $info = TrashUserInfo::where('user_id', $id);

        if($info){
            $info->forceDelete();
        }

        $user->forceDelete();

        //balik
        $users = TrashUser::select('id','name', 'email', 'role')->get();
        return Inertia::render('Settings/admin/UserTrashed', [
            'users' => $users,
        ]);
    }
}
