<?php

namespace App\Http\Controllers;

use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    function Register(Request $R)
    {
        try {
            $cred = new User();
            $cred->name = $R->name;
            $cred->email = $R->email;
            $cred->password = Hash::make($R->password);
            $cred->save();
            $response = ['status' => 200, 'message' => 'Cadastro Realizado com Sucesso!'];
            return response()->json($response);
        } catch (Exception $e) {
            $response = ['status' => 500, 'message' => $e];
        }
    }

    function Login(Request $R){
        $user = User::where('email', $R->email)->first();

       if($user!==null && Hash::check($R->password,$user->password)){
            $token = $user->createToken('Personal Access Token')->plainTextToken;
            $response = ['status' => 200, 'token' => $token, 'user' => $user, 'message' => 'Seja bem vindo de volta!'];
            return response()->json($response);
        }else {
            $response = ['status' => 500, 'message' => 'E-mail ou senha incorreta!'];
            return response()->json($response); 
        }

    
        
    }
}
