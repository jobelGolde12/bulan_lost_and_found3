<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Http\Request;
use Inertia\Inertia;

class UserTrashController extends Controller
{
    //Para sa mga na trash na user 
    public function index(){
         $users = User::onlyTrashed()->get(['id', 'name', 'email', 'role']);
        return Inertia::render('Settings/admin/UserTrashed', [
            'users' => $users,
        ]);
    }
     public function view($id){
        $user = User::onlyTrashed()->findOrFail($id);
        $info = UserInfo::where('user_id', $id)->onlyTrashed()->get();

        return Inertia::render('Settings/admin/ViewTrashSpecificUser', [
            'user' => $user,
            'info' => $info ?: null,
        ]);
    }
    public function restore($id){
        $user = User::onlyTrashed()->findOrFail($id);
        $info = UserInfo::where('user_id', $id)->onlyTrashed()->first();
        $user->restore();
        
        if($info){
           $info->restore(); 
        }
        return redirect()->back()->with(['message' => 'user restored'], 201);
    }
    public function delete($id){
        $user = User::findOrFail($id);
        $info = UserInfo::where('user_id', $id)->first();
        $user->delete();
        
        if($info){
           $info->delete(); 
        }
         $users = User::with('userInfo')->get();
        return redirect()->route('view.users', ['users' => $users])->with(['message' => 'user deleted'], 201);
    }

    public function deletePermanently($id){
        $user = User::onlyTrashed()->findOrFail($id);
        $info = UserInfo::where('user_id', $id)->onlyTrashed()->first();
        $user->forceDelete();
        
        if($info){
           $info->forceDelete(); 
        }
         return redirect()->back()->with(['message' => 'user deleted permanently'], 201);
    }
}
