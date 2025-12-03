<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ContactAdminModel;
use Inertia\Inertia;

class ContactAdminController extends Controller
{
    public function index()
    {
        return Inertia::render('admin/ContactAdmin');
    }

    public function sendMessage(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255',
            'message' => 'required|string',
        ]);

        ContactAdminModel::create([
            'name' => $request->name,
            'email' => $request->email,
            'message' => $request->message,
        ]);

    }
}
