<?php

namespace App\Http\Controllers;

use App\Models\ItemModel;
use App\Models\ViewLaterModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ViewLaterController extends Controller
{
    public function add($id){
        $viewLater = ViewLaterModel::where('item_id', $id)->first();
        if($viewLater){
        $viewLater->delete();
        }else{
             ViewLaterModel::create([
            'user_id' => Auth::id(),
            'item_id' => $id,
        ]);
        }
       
        return response()->json(['message' => 'the view later action was successfull'], 201);
    }
    public function viewWatchLater(){
         //get only the specific viewLater data base sa id ni user
            $userId = Auth::id();

            $allItems = ItemModel::with('user', 'viewLater')->get();

            $items = $allItems->filter(function ($item) use ($userId) {
                return $item->viewLater->contains('user_id', $userId);
            })->values();




         if(Auth::user()->role == 'admin'){
            return Inertia::render('viewLater/admin/Index', [
            'items' => $items
         ]);
         }else{
            return Inertia::render('viewLater/user/Index', [
            'items' => $items
         ]);
         }
    }
}
