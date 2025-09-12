<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\DeniedRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class DeniedRequestController extends Controller
{
    public function index($itemId){
        $deniedRequests = DeniedRequest::where(['user_id' => Auth::id(), 'request_id' => $itemId])->get();
        return Inertia::render('user/ViewDeniedRequests', [
            'deniedRequests' => $deniedRequests
        ]);
    }
}
