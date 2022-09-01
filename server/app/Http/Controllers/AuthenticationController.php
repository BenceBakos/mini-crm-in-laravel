<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use \App\Models\User;

class AuthenticationController extends Controller
{
    public function login(Request $request)
    {
        $attr = $request->validate([
            'email' => 'required|string|email|',
            'password' => 'required|string|min:6'
        ]);

        if (!Auth::attempt($attr)) {
            return $this->error('Credentials not match', 401);
        }

	$user = auth()->user();

	if ($user instanceof User){
	    return [
		'token' => $user->createToken('API Token')->plainTextToken
	    ];
	}
    }

    // this method signs out users by removing tokens
    public function logout()
    {
	$user = auth()->user();
	if ($user instanceof User){
	    $user->tokens()->delete();
	    return [
		'message' => 'Tokens Revoked'
	    ];
	}
    }
}
