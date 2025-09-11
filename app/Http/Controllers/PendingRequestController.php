<?php

namespace App\Http\Controllers;

use App\Models\ItemModel;
use App\Models\NotificationModel;
use App\Models\PendingRequest;
use App\Models\TrashModel;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PendingRequestController extends Controller
{
    public function index(){
        $items = PendingRequest::with(['user:id,name', 'user.userInfo:id,user_id,profile_pic'])->get();
        return Inertia::render('admin/ViewPendingRequest', [
            'items' => $items
        ]);
    }
    public function approveRequest($item)
    {
        $approveItem = PendingRequest::findOrFail($item);
    
        $data = $approveItem->only([
            'user_id',
            'title',
            'description',
            'category',
            'location',
            'status',
            'contact_info',
            'image_url',
            'category_id',
            'owner_phone_number',
            'reported_at',
        ]);
    
        ItemModel::create($data);
    
        $approveItem->delete(); 
    
        return redirect()->route('dashboard')->with('success', 'Item approved successfully.');
    }
        public function viewPending($item){
            $getItem = PendingRequest::findOrFail($item);
            $created_by = User::find($getItem?->user_id);

            $profile_pic = $created_by?->userInfo?->profile_pic ?? 'images/noImage.jpg';
            return Inertia::render('admin/ClickPendingRequest', [
                'item' => $getItem,
                'created_by' => $created_by,
                'profile_pic' => $profile_pic,
            ]);
        }

        public function denyRequestView($item){
            $getItem = PendingRequest::findOrFail($item);

            return Inertia::render('admin/DenyPendingRequest', [
                'item' => $getItem,
            ]);
        }
        public function denyRequest(Request $request, $item)
            {
                $pending = PendingRequest::findOrFail($item);

                $reason = $request->input('reason');

                $pending->save();

                NotificationModel::create([
                    'title' => 'Request Denied',
                    'user_id' => $pending->user_id,
                    'message' => 'Your item request (' . $pending->title . ') has been denied. Reason: ' . $reason,
                    'read_status' => 0
                ]);

                $pending->delete();

                return redirect()
                    ->route('dashboard')
                    ->with('success', 'Item denied successfully.');
            }

        public function faceTofaceVerification($item){
            if(!$item){
                return response()->json(['message' => 'User not found!'], 404);
            }
            $pending = PendingRequest::findOrFail($item);
            $userName = User::find($pending->user_id)->name;

            NotificationModel::create([
                'title' => 'Face to Face Verification',
                'user_id' => $pending->user_id,
                'message' => 'Hi ' . $userName . ', ' . ' your item (' . $pending->title . ') needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.',
                'read_status' => 0
            ]);
        return redirect()->route('dashboard')->with('success', 'Item approved successfully.');
        }
}
