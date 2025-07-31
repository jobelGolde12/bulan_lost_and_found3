<?php
namespace App\Http\Controllers;

use App\Models\ItemModel;
use App\Models\CategoryModel;
use App\Models\Comment;
use App\Models\ItemCategories;
use App\Models\LocationModel;
use App\Models\NotificationModel;
use App\Models\PendingRequest;
use App\Models\User;
use App\Models\UserInfo;
use App\Services\TwilioService;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

class ItemController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,svg|max:5120',
            'description' => 'required|string|max:255',
            'category' => 'required|string',
            'location' => 'required|string|max:255',
            'user_id' => 'required|integer',
            'owner_phone_number' => 'nullable|string|max:255|min:11',
            'status' => 'required|string|in:lost,found', 
        ]);
    
        $imagePath = $request->hasFile('image') 
            ? $request->file('image')->store('images', 'public') 
            : null;
    
        $category = CategoryModel::find($request->category);
        Log::info(['Category: ' => $category]);
        if(Auth::check() && Auth::user()->role == 'admin'){
            ItemModel::create([
                'title' => $request->name,
                'description' => $request->description,
                'status' => $request->status,
                'location' => $request->location,
                'image_url' => $imagePath ? asset('storage/' . $imagePath) : asset('images/noImage.jpg'),
                'category' => $request->category,
                'user_id' => $request->user_id,
                'owner_phone_number' => $request->owner_phone_number,
                'pending_status' => 'pending'
            ]);
        }else{
            PendingRequest::create([
                'title' => $request->name,
                'description' => $request->description,
                'status' => $request->status,
                'location' => $request->location,
                'image_url' => $imagePath ? asset('storage/' . $imagePath) : asset('images/noImage.jpg'),
                'category' => $request->category,
                'user_id' => $request->user_id,
                'owner_phone_number' => $request->owner_phone_number,
                'pending_status' => 'pending'
            ]);
        }
    
        return redirect()->back()->with(['message' => 'Item created.']);
    }

        public function reportItem()
    {
        $locations = LocationModel::all();
        if(Auth::check() && Auth::user()->role == 'admin'){
            return Inertia::render('admin/Report', [
                'categories' => CategoryModel::all(),
                'locations' => $locations,
            ]);
        }else{
            return Inertia::render('user/Report', [
                'categories' => CategoryModel::all(),
                'locations' => $locations,
            ]);
        }
    }


    // para sa profile (sa na himo ni user na item)
    public function viewItem($item){
        $getItem = ItemModel::find($item);
        $role = Auth::user()->role;
        return Inertia::render('admin/ViewItem', [
            'item' => $getItem,
            'role' => $role,
        ]);
    }

    // para sa dashboard (sa na himo san kada user na item)
    public function viewItemInfo($item){
        $getItem = ItemModel::with('comments')->findOrFail($item);
        $created_by = User::find($getItem?->user_id);
        $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');
        $currentUser = Auth::id();
        return Inertia::render('ViewItemInfo', [
            'item' => $getItem,
            'created_by' => $created_by,
            'profile' => $profile ?: 'NA',
            'comments' => $getItem->comments,
            'currentUser' => $currentUser ?: null,
        ]);
    }

    //kapag in view ni admin ang item
        public function viewItemInfoAsAdmin($item){
            $getItem = ItemModel::with('comments')->findOrFail($item);
            $created_by = User::find($getItem?->user_id);
            $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');
             $currentUser = Auth::id();
            return Inertia::render('admin/ViewItemInfoAsAdmin', [
                'item' => $getItem,
                'created_by' => $created_by,
                'profile' => $profile ?: 'NA',
                'comments' => $getItem->comments,
                 'currentUser' => $currentUser ?: null,
            ]);
        }
    // para sa pending request
    public function viewPending($item){
        $getItem = PendingRequest::findOrFail($item);
        $created_by = User::find($getItem?->user_id);
        // Log::info(['item data :' => $item]);
        return Inertia::render('admin/ViewItemInfoAsAdmin', [
            'item' => $getItem,
            'created_by' => $created_by
        ]);
    }
    // kapag in view ni user an item tas in click an visit {{ name }} ma kadto cya sa
    // profile san user na nag himo san item
    public function visitUser($id){

    }
    public function deleteItem($id){
        $item = ItemModel::findOrFail($id);

        // delete ang item
        try{
            $item->delete();
        }catch(Exception $e){
            Log::info("An error while deleting item => " . $e);
        }
        return redirect()->back()->with(['message' => 'Item deleted.']);

    }

    // para sa search features 
    public function search(Request $request)
    {
        $searchQuery = $request->input('query', '');

        $items = ItemModel::where('item_name', 'LIKE', '%' . $searchQuery . '%')->get();

        return Inertia::render('user/SearchResults', [
            'searchQuery' => $searchQuery,
            'items' => $items,
        ]);
    }

    //para sa resolve na item
    public function markAsResolve($id, $userId){
        $item = ItemModel::find($id);

        if (!$item) {
            return response()->json(['error' => 'Item not found'], 404);
        }
        if (!$userId) {
            return response()->json(['error' => 'user_id not found'], 404);
        }

        $item->status = 'Claimed';
        $item->resolved_at = now();
        $item->save();
        $categories = ItemCategories::all();
        $items = ItemModel::all();

        NotificationModel::create([
            'title' => 'Item Marked as Resolved',
            'user_id' => $userId,
            'message' => 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!',
            'read_status' => 0,
        ]);

         $user = UserInfo::where('user_id', $userId)->first();
         //TODO comment muna ang twilio habang wara pa signal
        // if ($user && $user->contact) {
        //     $twilio = new TwilioService();
        //     $twilio->sendSMS($user->contact, 'Hi! Your reported item has been resolved. Thank you for using our service.');
        // }

    return redirect()->back()->with(['message' => 'resolve sucessfully'], 201);
    }

       //     return Inertia::render('admin/Home', [
    //         'categories' => $categories,
    //         'items' => $items,
    // ]); 

    //Delete after one year na dpa resolved (para maka tipid storage)
    public function deleteAfterOneYear(){
        // nasa DeleteOldUnclaimedItems.php ang code 
    }
    public function getOwnerProfile($id)
    {
        $userName = User::where('id', $id)->value('name');
        $profilePic = UserInfo::where('user_id', $id)->value('profile_pic');
        if (!$userName || !$profilePic) {
            return response()->json(['error' => 'User not found'], 404);
        }

        $profile = UserInfo::where('user_id', $id)->first();

        return response()->json([
            'name' => $userName,
            'profile_pic' => $profile ? $profilePic : null,
        ]);
    }
    //Kapag d nag follow c user sa privacy & policy
    public function forceDelete($id){
        $item = ItemModel::findOrFail($id);
        $item->forceDelete();
        return redirect()->route('items')->with(['success' => 'item deleted successfully...']);
    }
}
