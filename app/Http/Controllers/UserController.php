<?php

namespace App\Http\Controllers;

use App\Models\ItemCategories;
use App\Models\LocationModel;
use App\Models\PendingRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class UserController extends Controller
{
    public function reportLostItem()
    {
        $categories = ItemCategories::all();
        $locations = LocationModel::all();
        return Inertia::render('admin/ReportLostItem', [
            'categories' => $categories,
            'locations' => $locations
        ]);
    }
    public function reportFoundItem()
    {
        $categories = ItemCategories::all();
        $locations = LocationModel::all();
        return Inertia::render('admin/ReportFoundItem', [
            'categories' => $categories,
            'locations' => $locations
        ]);
    }
    public function goToSettings()
    {
        return Inertia::render('user/Settings');
    }

    public function edit(User $user)
    {
        $userInfo = $user->info;

        return Inertia::render('user/EditProfile', [
            'user' => $user,
            'userInfo' => $userInfo,
        ]);
    }

    public function viewUser($id){
        $user = User::with(['userInfo', 'permission'])->findOrFail($id);
        $isSelf = $user->id == Auth::id() ? true : false; // return true kung kaniya yan info
        return Inertia::render('user/ViewUserInfo', [
            'user' => $user,
            'isSelf' => $isSelf,
        ]);
    }
    public function update(Request $request, User $user)
{
    dd("all request => " . $request->all());
    if($request->all()){
        Log::info('Received request:', $request->all());
    }else{
        Log::info("else message: " , ["no data in request"]);
    }
    // Validate input
    $validatedData = $request->validate([
        'profile_pic' => 'nullable|file|mimes:jpeg,png,jpg,gif|max:2048',
        'address' => 'nullable|string',
        'bio' => 'nullable|string',
        'contact' => 'nullable|string',
        'facebook_link' => 'nullable|string',
    ]);

    // Handle file upload
    if ($request->hasFile('profile_pic')) {
        $imagePath = $request->file('profile_pic')->store('images', 'public');
        $validatedData['profile_pic'] = asset('storage/' . $imagePath);
    }

    // Update user info
    try {
        $user->info()->updateOrCreate(['user_id' => $user->id], $validatedData);
    } catch (\Exception $e) {
        Log::error('Error updating user info: ' . $e->getMessage());
        return back()->withErrors(['error' => 'Failed to update user info.']);
    }

    return redirect()->route('user.edit', $user)->with('success', 'User information updated successfully.');
}
    public function myPendingRequests()
    {
        $items = PendingRequest::where('user_id', Auth::id())->get();
        return Inertia::render('user/MyPendingRequest', [
            'title' => 'My Pending Requests',
            'requests' => $items
        ]);
      
    }

     public function faceToFace($id)
    {
        $items = PendingRequest::where('id', $id)->get();
        // dd($items ? $items : "No items found");
        return Inertia::render('user/FaceToFace', [
            'title' => 'Face to Face Verification',
            'requests' => $items
        ]);
      
    }
}