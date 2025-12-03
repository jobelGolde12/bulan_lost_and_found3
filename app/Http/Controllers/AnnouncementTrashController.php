<?php

namespace App\Http\Controllers;

use App\Models\AnnouncementModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class AnnouncementTrashController extends Controller
{
      public function index()
    {
        $trashedAnnouncements = AnnouncementModel::where('user_id', Auth::id())->onlyTrashed()->get();
        if(Auth::user()->role == 'admin'){
            return Inertia::render('Settings/admin/AnnouncementTrashed', [
            'trashedAnnouncements' => $trashedAnnouncements ?: null,
            ]);
        }else{
            return Inertia::render('Settings/admin/AnnouncementTrash', [
            'announcements' => $trashedAnnouncements ?: null,
        ]);
        }
    }
    public function restore($id){
        $announcement = AnnouncementModel::where('user_id', Auth::id())->onlyTrashed()->findOrFail($id);
        $announcement->restore();
        return redirect()->back()->with(['message', 'announcement restored.'], 201);
    }
    public function delete($id){
        $announcement = AnnouncementModel::where('user_id', Auth::id())->onlyTrashed()->findOrFail($id);
        $announcement->forceDelete();
        return redirect()->back()->with(['message', 'announcement deleted.'], 201);
    }
}
