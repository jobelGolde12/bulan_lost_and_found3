<?php

namespace App\Http\Controllers;

use App\Models\MyPermissionModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MyPermissionController extends Controller
{
    public function togglePhonePermission(){
        //Create muna kung wara pa data. Tsaka eh update
        $myPermission = MyPermissionModel::firstOrCreate(
        ['user_id' => Auth::id()],
        [
            'isPhoneAllow' => true,
            'isEmailAllow' => true
        ]
    );

        $myPermission->update([
        'isPhoneAllow' => !$myPermission->isPhoneAllow,
        ]);
        return redirect()->back()->with(['message' => 'permission modified']);
    }

    public function toggleEmailPermission(){
        $myPermission = MyPermissionModel::firstOrCreate(
        ['user_id' => Auth::id()],
        [
            'isPhoneAllow' => true,
            'isEmailAllow' => true
        ]
    );

        $myPermission->update([
        'isEmailAllow' => !$myPermission->isEmailAllow,
        ]);
        return redirect()->back()->with(['message' => 'permission modified']);
    }

}
