<?php

namespace App\Http\Controllers;

use App\Models\Agente;
use Doctrine\DBAL\Query\QueryException;
use Firebase\JWT\JWT;
use Illuminate\Database\QueryException as DatabaseQueryException;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AgenteSaudeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function login(Request $request)
    {
      $agente = Agente::where('cpf', $request->cpf)->first();


      if (!$agente) {
          return response()->json(['error' => 'Usuário não encontrado'], 404);
      }
    
      if (Hash::check($request->password, $agente->password)) {
         
          $payload = [
              'iss' => "laravel-jwt", 
              'sub' => $agente->id, 
              'iat' => time(), 
              'exp' => time() + 60*60*24 
          ];
    
          $key = env('JWT_SECRET', '123456'); 
          $token = JWT::encode($payload, $key, 'HS256');
    
       
          $agente->password = '';
    
        
          return response()->json([
              'success' => 'Login bem-sucedido',
              'agente' => $agente,
              'token' => $token
          ]);
      } else {
          return response()->json(['error' => 'Senha incorreta'], 401);
      }
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $agente = new Agente();
        $agente->nome = $request->nome;
        $agente->telefone = $request->telefone;
        $agente->cpf = $request->cpf;
        $agente->password = Hash::make($request->password);

        if (!is_numeric($agente->telefone)){
          return response()->json(
            [
                "mensagem" => "Telefone deve conter somente numeros!"
            ], 400
        );
        }
          if(strlen($agente->telefone) > 11 || strlen($agente->telefone) < 10){
            return response()->json(
              [
                  "mensagem" => "Telefone ser fixo ou Celular!"
              ], 400
          );

          }


        try {
            $agente->save();
            return response()->json(
                [
                    "mensagem" => "Agente cadastrado com sucesso",
                    "agente" => $agente
                ], 200
            );
        } catch (DatabaseQueryException $e) {
            if ($e->errorInfo[1] == 1062) {
                return response()->json(
                    [
                        "mensagem" => "CPF ja cadastrado"
                    ], 400
                );
            } else {
                return response()->json(
                    [
                        "mensagem" => "Erro ao cadastrar o responsável"
                    ], 500
                );
            }
        }
    }
    

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
