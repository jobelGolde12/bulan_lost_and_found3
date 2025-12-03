<?php

namespace App\Http\Controllers;

use App\Models\NotificationModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class NotificationTrashController extends Controller
{
    public function index(){
         $notifications = NotificationModel::where('user_id', Auth::id())->onlyTrashed()->get();
        if(Auth::user()->role == 'user'){
            return Inertia::render('Settings/user/NotificationTrashed', [
                'notifications' => $notifications,
            ]);
        }else{
            return Inertia::render('Settings/admin/NotificationTrashed', [
                'notifications' => $notifications,
            ]);
        }
    }
    public function restore($id){
         $notification = NotificationModel::where('user_id', Auth::id())->onlyTrashed()->findOrFail($id);
         $notification->restore();
         return redirect()->back()->with(['message' => 'Notification restored.'], 201);
    }
    public function delete($id){
         $notification = NotificationModel::where('user_id', Auth::id())->onlyTrashed()->findOrFail($id);
        $notification->forceDelete();
         return redirect()->back()->with(['message' => 'Notification deleted.'], 201);
    }
}
