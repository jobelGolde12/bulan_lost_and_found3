<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use App\Models\ItemModel;
use App\Models\MyPermissionModel;
use App\Models\User;
use App\Models\UserInfo;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use Inertia\Response;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function index(){
        $items = ItemModel::where('user_id', Auth::id())->get();
        $userInfo = UserInfo::where('user_id', Auth::id())->first();
        $permission = MyPermissionModel::where('user_id', Auth::id())->first();
        if(Auth::check() && Auth::user()->role === 'admin'){
            return Inertia::render('admin/Profile', [
                'items' => $items, 
                'userInfo' => $userInfo, 
                'permission' => $permission,
            ]);
        }else{
            return Inertia::render('user/Profile', [
                'items' => $items,  
                'userInfo' => $userInfo,
                'permission' => $permission,
            ]);
        }
    }
    public function edit(Request $request): Response
    {
        $user = User::find(Auth::id());
        $info = UserInfo::find(Auth::id());
        if(Auth::user()->role == 'admin'){
            return Inertia::render('admin/EditProfile', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
            'user' => $user, 
            'info' => $info,
        ]);
        }

        return Inertia::render('user/EditProfile', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
            'info' => $info,
            'user' => $user
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request): RedirectResponse
    {
        $request->user()->fill($request->validated());

        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }

        $request->user()->save();

        return Redirect::route('profile.edit');
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validate([
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }

    //kapag in update ni admin or user ang kaniya profile information (EditProfile.vue)
    public function userUpdate(Request $request, $id)
{
    if (Auth::id() !== (int) $id) {
        return response()->json(['error' => 'Unauthorized'], 403);
    }

    $validated = $request->validate([
        'profile_pic' => 'nullable|image|mimes:jpg,png,jpeg|max:5120',
        'address' => 'nullable|string|max:255',
        'bio' => 'nullable|string|max:1000',
        'contact' => 'nullable|string|max:15',
        'facebook_link' => 'nullable|url|max:255',
    ]);

    $userInfo = UserInfo::where('user_id', $id)->firstOrFail();

    // Enhance the logic for image storage
    if ($request->hasFile('profile_pic')) {
        // Delete old file if it exists
        if ($userInfo->profile_pic) {
            Storage::disk('public')->delete($userInfo->profile_pic);
        }

        // Store new profile picture in the public disk with a unique name
        $path = $request->file('profile_pic')->storePublicly('profile_pics', 'public');
        $userInfo->profile_pic = $path;
    }

    // Update other fields using mass assignment
    $userInfo->update([
        'address' => $validated['address'] ?? $userInfo->address,
        'bio' => $validated['bio'] ?? $userInfo->bio,
        'contact' => $validated['contact'] ?? $userInfo->contact,
        'facebook_links' => $validated['facebook_link'] ?? $userInfo->facebook_link,
    ]);

    return response()->json(['message' => 'Profile updated successfully!'], 200);
}
    
    public function userUpdatePost(Request $request, $id)
{
    if (Auth::id() !== (int) $id) {
        return response()->json(['error' => 'Unauthorized'], 403);
    }

    $userInfo = UserInfo::where('user_id', $id)->first();

    if (!$userInfo) {
        return response()->json(['error' => 'User info not found'], 404);
    }

    try {
    $validated = $request->validate([
        'address' => 'nullable|string|max:255',
        'profile_pic' => 'nullable|file|image|mimes:jpg,png,jpeg|max:5120',
        'bio' => 'nullable|string|max:1000',
        'contact' => 'nullable|string|max:15',
        'facebook_links' => 'nullable|url',
    ]);
} catch (\Illuminate\Validation\ValidationException $e) {
    Log::error("Validation failed", $e->errors());
    throw $e; 
}
    if ($request->hasFile('profile_pic')) {
        if ($userInfo->profile_pic) {
            Storage::delete($userInfo->profile_pic);
        }
        $validated['profile_pic'] = $request->file('profile_pic')->store('images', 'public');
    }
    if($validated['profile_pic'] == null){
        $validated['profile_pic'] = $userInfo->profile_pic;
    }
    $userInfo->fill($validated);
    $userInfo->save();

    return redirect()->back()->with(['message: ' => "profile edited successfully..."]);
}


}


//     if(!$userInfo){
//         return response()->json(['error: ' => "cannot find user info with that id"]);
//     }
//     if ($request->hasFile('profile_pic')) {
//         if ($userInfo->profile_pic) {
//             Storage::delete($userInfo->profile_pic);
//         }

//         $userInfo->profile_pic = $request->file('profile_pic')->store('profile_pics');
//     }

//     if ($request->filled('address')) {
//     $userInfo->address = $validated['address'];
// }

// if ($request->filled('bio')) {
//     $userInfo->bio = $validated['bio'];
// }


//     $userInfo->contact = $validated['contact'] ?? $userInfo->contact;
//     $userInfo->facebook_link = $validated['facebook_link'] ?? $userInfo->facebook_link;

