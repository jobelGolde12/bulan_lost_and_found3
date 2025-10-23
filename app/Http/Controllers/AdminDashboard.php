<?php

namespace App\Http\Controllers;

use App\Models\ItemCategories;
use App\Models\ItemModel;
use App\Models\LocationModel;
use App\Models\MessageModel;
use App\Models\TargetResolvedCases;
use App\Models\TotalFound;
use App\Models\TotalLost;
use App\Models\User;
use App\Models\UserInfo;
use App\Models\ViewLaterModel;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class AdminDashboard extends Controller
{
    public function index(){
        return Inertia::render('admin/Dashboard');
    }
    public function item(){
        $categories = ItemCategories::all();
        //get only the specific viewLater data base sa id ni user
        $userId = Auth::id();
        $items = ItemModel::whereIn('status', ['Lost', 'Found'])
        ->with('user', 'user.userInfo:id,user_id,profile_pic')
        ->with(['viewLater' => function ($query) use ($userId) {
        $query->where('user_id', $userId);
        }])->orderBy('created_at', 'desc')->get();

        $locations = LocationModel::select('id','name')->get();

            return Inertia::render('admin/Home', [
                'categories' => $categories,
                'items' => $items,
                'role' => 'admin',
                'locations' => $locations,
        ]); 
}
    public function filterByLocation($id){

        $currentLocation = LocationModel::findOrFail($id);

        $categories = ItemCategories::all();
        //get only the specific viewLater data base sa id ni user
        $userId = Auth::id();
        $items = ItemModel::whereIn('status', ['Lost', 'Found'])
        ->where('location', $currentLocation->name)
        ->with('user', 'user.userInfo:id,user_id,profile_pic')
        ->with(['viewLater' => function ($query) use ($userId) {
        $query->where('user_id', $userId);
        }])->orderBy('created_at', 'desc')->get();

        $locations = LocationModel::select('id','name')->get();

            return Inertia::render('admin/Home', [
                'categories' => $categories,
                'items' => $items,
                'role' => 'admin',
                'locations' => $locations,
                'currentLocation' => $currentLocation->name,
        ]); 
}

    public function viewUsers(){
        $users = User::with('userInfo')->get();
        return Inertia::render('admin/users/Index', [
            'users' => $users,
        ]);
    }

    public function viewUser($id){
        // sa database true ang default value san isPhoneAllow & isEmailAllow
        $user = User::with(['userInfo', 'permission'])->findOrFail($id);
        return Inertia::render('admin/users/ViewUserInfo', [
            'user' => $user,
        ]);
    }
  public function hasMessage()
    {
        $currentUserId = Auth::id();

        $unreadFromUniqueSenders = MessageModel::where('receiver_id', $currentUserId)
            ->whereNull('read_at')
            ->select('sender_id')         
            ->distinct()                  
            ->count();                   

        return response()->json(['unique_senders' => $unreadFromUniqueSenders]);
    }



    public function targetResolveCases($target, $type){
        $currentTarget = TargetResolvedCases::select(['id','target_value'])->first();
        
        if($type == 'increase'){
            $target = $target + 100;
        }else{
            $target = $target - 100;
        }
        
        $currentTarget->update([
            'target_value' => $target
        ]);

        return response()->json($currentTarget->target_value);
    }
    public function getTargetResolveCases(){
        $currentTarget = TargetResolvedCases::select(['id','target_value'])->first();
        return response()->json($currentTarget->target_value);
    }

    public function getItems(Request $request)
        {
            $status = $request->query('status');
            $query = ItemModel::query();
            
            if ($status) {
                if ($status === 'Unsolved') {
                    $query->whereDate('created_at', '<=', now()->subYear());
                } elseif ($status === 'Resolved') {
                    $query->where('status', 'Claimed');
                } else {
                    $query->where('status', $status);
                }
            }

            $items = $query->orderBy('created_at', 'desc')->paginate(15);

            return response()->json($items);
        }
    public function getReportPerBarangay(){
        try{
            $losts = TotalLost::all();
            $founds = TotalFound::all();
            $losts->push($founds);
            $data = $losts;
                return response()->json($data, 200);
        }catch(Exception $e){
            Log::info(['error: ' => $e]);
        }
    }
    public function itemEdit($id){
         $item = ItemModel::findOrFail($id);

        return Inertia::render('admin/item/Edit', [
            'item' => $item
        ]);
    }

        public function itemUpdate(Request $request, $id)
        {
            $request->validate([
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'category' => 'nullable|string|max:255',
                'location' => 'nullable|string|max:255',
                'status' => 'required|in:Lost,Found,Claimed',
                'contact_info' => 'nullable|string|max:255',
                'owner_phone_number' => 'nullable|string|max:255',
                'date' => 'nullable|date',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:5120', // max 5MB
                'remove_image' => 'nullable|boolean',
            ]);

            $item = ItemModel::findOrFail($id);

            // Handle remove image flag first
            if ($request->boolean('remove_image')) {
                if ($item->image_url) {
                    // Stored as Storage::url($path) -> /storage/images/...
                    $storagePath = preg_replace('#^/storage/#', '', $item->image_url);
                    if (Storage::disk('public')->exists($storagePath)) {
                        Storage::disk('public')->delete($storagePath);
                    }
                }
                $item->image_url = null;
            }

            // Handle new uploaded image (replace old)
            if ($request->hasFile('image')) {
                // delete old if exists
                if ($item->image_url) {
                    $oldPath = preg_replace('#^/storage/#', '', $item->image_url);
                    if (Storage::disk('public')->exists($oldPath)) {
                        Storage::disk('public')->delete($oldPath);
                    }
                }

                $path = $request->file('image')->store('images', 'public'); // saved to storage/app/public/images
                $item->image_url = Storage::url($path); // returns /storage/images/...
            }

            // Update other fields
            $item->title = $request->input('title');
            $item->description = $request->input('description');
            $item->category = $request->input('category');
            $item->location = $request->input('location');
            $item->status = $request->input('status');
            $item->contact_info = $request->input('contact_info');
            $item->owner_phone_number = $request->input('owner_phone_number');
            $item->date = $request->input('date');
            $item->resolved_at = $request->input('resolved_at') ?? $item->resolved_at;

            $item->save();

            return redirect()->route('dashboard')->with('success', 'Item updated successfully!');
        }

}
