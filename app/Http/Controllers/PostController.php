<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\ItemModel;
use App\Models\PendingRequest;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PostController extends Controller
{
    public function index(){
    $items = ItemModel::where('user_id', Auth::id())
    ->with(['user' => function ($query) {
        $query->select( 'id' , 'name');
    }])
    ->orderBy('created_at', 'desc')
    ->get();
    
    if(Auth::user()->role === 'user'){
        return Inertia::render('user/Posts', [
        'items' => $items,
      ]);
    }else if(Auth::user()->role === 'admin'){
        return Inertia::render('admin/Posts', [
        'items' => $items,
      ]);
    }

    }

    public function pending(){
        try{
            $pendingRequests = PendingRequest::where('user_id', Auth::id())
            ->where('pending_status', 'pending')
            ->with(['user' => function($query){
                $query->select('id','name');
            }])
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'data' => $pendingRequests
        ]);
        }catch(Exception $e){
            Log::info(['an error while fething pending post: ' => $e]);
            return response()->json(['an error while fething pending post: ' => $e], 500);
        }
    }
}
