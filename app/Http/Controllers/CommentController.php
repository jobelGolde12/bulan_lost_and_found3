<?php

namespace App\Http\Controllers;

use App\Models\Comment;
use App\Models\ItemModel;
use App\Models\User;
use App\Models\UserInfo;
use BackedEnum;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth as FacadesAuth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class CommentController extends Controller
{
    public function store(Request $request){
        $request->validate([
            'user_id' => 'required|string|max:255',
            'item_id' => 'required|string|max:255',
            'content' => 'required|string|max:255',
        ]);
        Comment::create([
            'user_id' => FacadesAuth::id(),
            'item_id' => $request->item_id,
            'content' => $request->content,
        ]);
         $getItem = ItemModel::with('comments')->findOrFail($request->item_id);
            $created_by = User::find($getItem?->user_id);
            $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');
            $currentUser = FacadesAuth::id();
            if(FacadesAuth::user()->role == 'admin'){
                return Inertia::render('admin/ViewItemInfoAsAdmin', [
                'item' => $getItem,
                'created_by' => $created_by,
                'profile' => $profile ?: 'NA',
                'comments' => $getItem->comments,
                'currentUser' => $currentUser ?: null,
            ]);
            }else{
                return Inertia::render('ViewItemInfo', [
                'item' => $getItem,
                'created_by' => $created_by,
                'profile' => $profile ?: 'NA',
                'comments' => $getItem->comments,
                'currentUser' => $currentUser ?: null,
            ]);
            }
    }

    public function delete($id){
        $comment = Comment::find($id);
        $itemId = $comment->item_id;
        if(!$comment){
            return response()->json(['message' => 'cannot find comment', 404]);
        }

        if(FacadesAuth::id() != $comment->user_id){
            return response()->json(['message' => 'user not allowed to delete this comment', 404]);
        }
        $comment->delete();
        return redirect()->back()->with(['message' => 'comment deleted']);
            // $getItem = ItemModel::with('comments')->findOrFail($itemId);
            // $created_by = User::find($getItem?->user_id);
            // $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');
            //  $currentUser = FacadesAuth::id();

            //  if(FacadesAuth::user()->role == 'admin'){
            //     return Inertia::render('admin/ViewItemInfoAsAdmin', [
            //     'item' => $getItem,
            //     'created_by' => $created_by,
            //     'profile' => $profile ?: 'NA',
            //     'comments' => $getItem->comments,
            //     'currentUser' => $currentUser ?: null,
            // ]);
            // }else{
            //     return Inertia::render('ViewItemInfo', [
            //     'item' => $getItem,
            //     'created_by' => $created_by,
            //     'profile' => $profile ?: 'NA',
            //     'comments' => $getItem->comments,
            //     'currentUser' => $currentUser ?: null,
            // ]);
            // }
    }
}
