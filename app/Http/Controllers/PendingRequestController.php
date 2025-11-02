<?php

namespace App\Http\Controllers;

use App\Models\DeniedRequest;
use App\Models\ItemModel;
use App\Models\NotificationModel;
use App\Models\PendingRequest;
use App\Models\TotalFound;
use App\Models\TotalLost;
use App\Models\TrashModel;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PendingRequestController extends Controller
{
    public function index(){
        $items = PendingRequest::with(['user:id,name', 'user.userInfo:id,user_id,profile_pic'])
        ->orderBy('created_at', 'desc')
        ->get();
        return Inertia::render('admin/ViewPendingRequest', [
            'items' => $items
        ]);
    }
    public function approveRequest($item)
    {
        $approveItem = PendingRequest::findOrFail($item);
    
        $data = $approveItem->only([
            'id',
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
        $notification = NotificationModel::create([
            'title' => 'Request Approved',
            'user_id' => $approveItem->user_id,
            'message' => 'Your item request (' . $approveItem->title . ') has been approved and is now live on the platform.',
            'read_status' => 0,
        ]);
       
        $item = ItemModel::create($data);
        if(strtolower($item->status) === 'lost'){
                $totalLost = TotalLost::create([
                    'total' => 1,
                    'date_lost' => Carbon::parse($item->created_at)->timezone(config('app.timezone')),
                    'location' => $data["location"],
                ]);
                $totalLost->save();
            }elseif(strtolower($item->status) === 'Found'){
                $totalFound = TotalFound::create([
                    'total' => 1,
                    'date_found' => Carbon::parse($item->created_at)->timezone(config('app.timezone')),
                    'location' => $data["location"],
                ]);
                $totalFound->save();
            }

        $notification->item_id = $item->id;
        $notification->save();

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

                $notification = NotificationModel::create([
                    'title' => 'Request Denied',
                    'user_id' => $pending->user_id,
                    'message' => 'Your item request (' . $pending->title . ') has been denied. Reason: ' . $reason,
                    'read_status' => 0,
                    'item_id' => $pending->id,
                ]);
               

                $deniedRequest = DeniedRequest::create([
                    'request_id' => $pending->id,
                    'user_id' => $pending->user_id,
                    'reason' => $reason,
                ]);
                $notification->item_id = $deniedRequest->request_id;
                $notification->save();

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

            $notification =NotificationModel::create([
                'title' => 'Face to Face Verification',
                'user_id' => $pending->user_id,
                'message' => 'Hi ' . $userName . ', ' . ' your item (' . $pending->title . ') needs to be verified face to face. We encourage you to visit the PNP for additional verification of the item you wish to post.',
                'read_status' => 0,
                'item_id' => $pending->id,
            ]);

            $notification->item_id = $pending->id;
              $notification->save();
        return redirect()->route('dashboard')->with('success', 'Item approved successfully.');
        }
}
