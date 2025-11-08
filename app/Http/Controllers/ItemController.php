<?php
namespace App\Http\Controllers;

use App\Models\BlockedMessages;
use App\Models\ItemModel;
use App\Models\CategoryModel;
use App\Models\Comment;
use App\Models\ItemCategories;
use App\Models\LocationModel;
use App\Models\MessageModel;
use App\Models\NotificationModel;
use App\Models\PendingRequest;
use App\Models\PinnedChatsModel;
use App\Models\RemovePinnedMessages;
use App\Models\TotalFound;
use App\Models\TotalLost;
use App\Models\User;
use App\Models\UserInfo;
use App\Services\SemaphoreService;
use App\Services\TwilioService;
use Carbon\Carbon as CarbonCarbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
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
        'description' => 'required|string|max:1000',
        'category' => 'required|string',
        'location' => 'required|string|max:255',
        'user_id' => 'required|integer',
        'owner_phone_number' => 'nullable|string|max:255|min:11',
        'status' => 'required|string|in:lost,found', 
        'date' => 'required|date'
    ]);

    //  Upload image to storage/app/public/images
    $imagePath = $request->hasFile('image')
        ? $request->file('image')->storePublicly('images', 'public')
        : null;

    $category = CategoryModel::find($request->category);
    if (!$category) {
        return redirect()->back()
            ->withErrors(['category' => 'Invalid category selected.'])
            ->withInput();
    }

    $wordsToCheck = $request->name . ' ' . $request->description;
    $profanityWords = $this->checkProfanity($wordsToCheck);

    if (!empty($profanityWords)) {
        return back()->withErrors([
            'description' => 'The information you provide contains profanity, please avoid using such words.',
        ])->withInput();
    }

    $imageUrl = $imagePath
        ? url('storage/' . $imagePath)
        : url('images/noImage.jpg');

    if (Auth::check() && Auth::user()->role == 'admin') {
        $item = ItemModel::create([
            'title' => $request->name,
            'description' => $request->description,
            'status' => $request->status,
            'location' => $request->location,
            'image_url' => $imageUrl,
            'category' => $category->name ?: "Uncategorized",
            'user_id' => $request->user_id,
            'owner_phone_number' => $request->owner_phone_number,
            'pending_status' => 'pending',
            'created_at' => Carbon::parse($request->date)->timezone(config('app.timezone')),
        ]);

        if (strtolower($item->status) === 'lost') {
            TotalLost::create([
                'total' => 1,
                'date_lost' => Carbon::parse($request->date)->timezone(config('app.timezone')),
                'location' => $request->location ?: 'N/A'
            ]);
        } elseif (strtolower($item->status) === 'found') {
            TotalFound::create([
                'total' => 1,
                'date_found' => Carbon::parse($request->date)->timezone(config('app.timezone')),
                'location' => $request->location ?: 'N/A'
            ]);
        }
    } else {
        PendingRequest::create([
            'title' => $request->name,
            'description' => $request->description,
            'status' => $request->status,
            'location' => $request->location,
            'image_url' => $imageUrl,
            'category' => $category->name ?: "Uncategorized",
            'user_id' => $request->user_id,
            'owner_phone_number' => $request->owner_phone_number,
            'pending_status' => 'pending',
            'created_at' => Carbon::parse($request->date)->timezone(config('app.timezone')),
        ]);
    }

    return redirect()->back()->with(['message' => 'Item created.']);    
}


       public function checkProfanity($words)
{
    $urls = [
        "https://filipinoprofanitywordapi.netlify.app/data/pureFilipino.json",
        "https://filipinoprofanitywordapi.netlify.app/data/regional.json",
    ];

    $allProfanityWords = [];

    foreach ($urls as $url) {
        try {
            $response = Http::timeout(10) // Increased timeout
                         ->retry(3, 100) // Retry 3 times with 100ms delay
                         ->withOptions([
                             'verify' => true, // Ensure SSL verification
                         ])
                         ->get($url);

            if ($response->successful()) {
                $data = $response->json();
                foreach ($data as $item) {
                    if (isset($item['word'])) {
                        $allProfanityWords[] = $item['word'];
                    }
                }
            } else {
                Log::warning("Failed to fetch from {$url}, status: " . $response->status());
            }
        } catch (\Exception $e) {
            Log::error("Error fetching from {$url}: " . $e->getMessage());
            continue; // Continue with next URL instead of stopping
        }
    }

    // Fallback to local cache if API fails
    if (empty($allProfanityWords)) {
        $allProfanityWords = $this->getCachedProfanityWords();
    }

    $found = [];
    foreach ($allProfanityWords as $badWord) {
        if (stripos($words, $badWord) !== false) {
            $found[] = $badWord;
        }
    }

    Log::info([
        'Checking profanity in input:' => $words,
        'Found:' => $found,
    ]);

    return $found;
}

// Add this method for fallback
private function getCachedProfanityWords()
{
    // You can cache the words locally to avoid API dependency
    $cachedWords = cache('profanity_words');
    
    if ($cachedWords) {
        return $cachedWords;
    }
    
    // Default fallback words if cache is empty
    return [
        'putang', 'gago', 'bobo', 'tanga', 'ulol',
        'lintik', 'punyeta', 'leche', 'buwisit', 'sira'
    ];
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
        $getItem = ItemModel::with('comments.user.userInfo')->findOrFail($item);
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
       public function viewItemInfoAsAdmin($item)
        {
            $getItem = ItemModel::with(['comments.user.userInfo']) 
                ->findOrFail($item);

            $currentUser = Auth::id();
             $created_by = User::find($getItem?->user_id);
            $profile = UserInfo::where('user_id' , $getItem->user_id)->value('profile_pic');

            return Inertia::render('admin/ViewItemInfoAsAdmin', [
                'item' => $getItem,
                'comments' => $getItem->comments,
                'currentUser' => $currentUser ?: null,
                 'created_by' => $created_by,
                 'profile' => $profile ?: 'NA',

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
public function markAsResolve($id, $userId)
{
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

    $notification = NotificationModel::create([
        'title' => 'Item Marked as Resolved',
        'user_id' => $userId,
        'message' => 'The item you reported has been marked as resolved by the administrator. Thank you for using our service!',
        'read_status' => 0,
    ]);

    $notification->item_id = $item->id;
    $notification->save();

    $user = UserInfo::where('user_id', $userId)->first();
    
    if ($user->contact || $item->owner_phone_number) {
        $contact = $user->contact ?: $item->owner_phone_number;

        if (preg_match('/^0\d+$/', $contact)) {
            $contact = '+63' . substr($contact, 1); // Convert 0917... -> +63917...
        }

        $semaphore = new SemaphoreService();
        $smsResponse = $semaphore->sendSMS(
            $contact,
            'Bulan Lost and Found: The item you reported has been marked as resolved by the administrator. Thank you for using our service!'
        );

        Log::info('Semaphore SMS sent on markAsResolve', [
            'user_id' => $userId,
            'to'      => $contact,
            'response' => $smsResponse,
        ]);
    }

    return redirect()->back()->with(['message' => 'resolve successfully'], 201);
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
        
        NotificationModel::create([
            'title' => 'Post Deleted by Admin',
            'user_id' => $item->user_id,
            'message' => "Your post titled '{$item->title}' has been deleted by an admin due to violating our guidelines.",
            'read_status' => 0
        ]);
        $item->forceDelete();
        
        if(Auth::user()->role === 'admin'){
            return redirect()->route('items')->with(['success' => 'item deleted successfully...']);
        }else{
            return redirect()->route('dashboard')->with(['success' => 'item deleted successfully...']);
        }
    }

    // Sa message admin san view item info
           public function viewChat()
{
    $pinnedMessages = PinnedChatsModel::all();
    $pinnedUser = null;

    $currentUserId = Auth::id();
    $removedUser = RemovePinnedMessages::where('user_id', $currentUserId)->get(['id', 'removed_user']);
    $blockedUser = BlockedMessages::where('user_id', $currentUserId)->get(['id', 'blocked_user']);
    $excludedIds = $removedUser->pluck('removed_user')->toArray();
    $excludedBlockedIds = $blockedUser->pluck('blocked_user')->toArray();

    // Only get users who are not removed or blocked
    if (empty($excludedIds)) {
        $users = User::select(['id', 'name', 'role'])->get();
    } else {
        $users = User::whereNotIn('id', $excludedIds)
            ->select(['id', 'name', 'role'])
            ->get();
    }

    // Retrieve pinned messages and their associated user information
    if ($pinnedMessages->isNotEmpty()) {
        $userIds = $pinnedMessages->pluck('user_id')->unique();

        if (empty($excludedIds)) {
            $pinnedUser = User::with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        } else {
            $pinnedUser = User::whereNotIn('id', $excludedIds)
                ->whereNotIn('id', $excludedBlockedIds)
                ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }

        if (!empty($excludedBlockedIds)) {
            $pinnedUser = User::whereNotIn('id', $excludedIds)
                ->whereNotIn('id', $excludedBlockedIds)
                ->with('userInfo')
                ->whereIn('id', $userIds)
                ->get()
                ->map(function ($user) {
                    return [
                        'id' => $user->id,
                        'name' => $user->name,
                        'profile_pic' => $user->userInfo->profile_pic ?? null,
                    ];
                });
        }
    }

    // ✅ Get only one admin user (first one found)
    $adminUser = User::with('userInfo')
        ->where('role', 'admin')
        ->first();

    // If no admin found
    if (!$adminUser) {
        return redirect()->back()->with('error', 'No admin user found.');
    }

    // Retrieve conversation between current user and admin
    $data2 = MessageModel::where(function ($query) use ($adminUser, $currentUserId) {
        $query->where('sender_id', $currentUserId)
              ->where('receiver_id', $adminUser->id);
    })->orWhere(function ($query) use ($adminUser, $currentUserId) {
        $query->where('sender_id', $adminUser->id)
              ->where('receiver_id', $currentUserId);
    })->orderBy('created_at', 'asc')
      ->get();

    $message = [
        'data1' => $adminUser, // Admin user's info
        'data2' => $data2,     // Conversation messages
    ];

    return Inertia::render('Message', [
        'pinned' => $pinnedUser,
        'message' => $message ?: null,
        'users' => $users,
        'currentUserId' => $currentUserId,
    ]);
}


}
