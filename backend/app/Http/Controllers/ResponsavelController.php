<?php

namespace App\Http\Controllers;

use App\Models\Responsavel;
use Firebase\JWT\JWT;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\QueryException;

class ResponsavelController extends Controller

{
  public function index(){

    $responsaveis = Responsavel::all();

    return response()->json([
      "mensagem" => "Lista de Responsaveis",
      "responsaveis" => $responsaveis
    ]);
      
  }

  public function login(Request $request)
{
  $responsavel = Responsavel::where('cpf', $request->cpf)->first();


  if (!$responsavel) {
      return response()->json(['error' => 'Usuário não encontrado'], 404);
  }

  if (Hash::check($request->password, $responsavel->password)) {
     
      $payload = [
          'iss' => "laravel-jwt", 
          'sub' => $responsavel, 
          'iat' => time(), 
          'exp' => time() + 60*60*24 
      ];

      $key = env('JWT_SECRET', '123456'); 
      $token = JWT::encode($payload, $key, 'HS256');

   
      $responsavel->password = '';

    
      return response()->json([
          'success' => 'Login bem-sucedido',
          'responsavel' => $responsavel,
          'token' => $token
      ]);
  } else {
      return response()->json(['error' => 'Senha incorreta'], 401);
  }
}

    public function create(Request $request)
    {
        $responsavel = new Responsavel();
        $responsavel->nome = $request->nome;
        $responsavel->telefone = $request->telefone;
        $responsavel->cpf = $request->cpf;
        $responsavel->password = Hash::make($request->password);

        if (!is_numeric($responsavel->telefone)){
          return response()->json(
            [
                "mensagem" => "Telefone deve conter somente numeros!"
            ], 400
        );
        }
          if(strlen($responsavel->telefone) > 11 || strlen($responsavel->telefone) < 10){
            return response()->json(
              [
                  "mensagem" => "Telefone ser fixo ou Celular!"
              ], 400
          );

          }


        try {
            $responsavel->save();
            return response()->json(
                [
                    "mensagem" => "Responsável cadastrado com sucesso"
                ], 200
            );
        } catch (QueryException $e) {
            if ($e->errorInfo[1] == 1062) {
                return response()->json(
                    [
                        "mensagem" => "CPF duplicado: '05574916909'"
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

    public function show(string $id)
    {
      $responsavel = Responsavel::find($id);

      if(!$responsavel){
        return response()->json(["menssage" => "Nenhum registro encontrado!"]);
      }

      return response()->json([$responsavel]);
    }

    public function update(Request $request, string $id) 
    {
      $responsavel = Responsavel::find($id);

      $responsavel->nome = $request->nome;
      $responsavel->telefone = $request->telefone;
      $responsavel->cpf = $request->cpf;
      $responsavel->password = Hash::make($request->password);

      if (!is_numeric($responsavel->telefone)){
        return response()->json(
          [
              "mensagem" => "Telefone deve conter somente numeros!"
          ], 400
      );
      }
        if(strlen($responsavel->telefone) > 11 || strlen($responsavel->telefone) < 10){
          return response()->json(
            [
                "mensagem" => "Telefone ser fixo ou Celular!"
            ], 400
        );

        }


      try {
          $responsavel->save();
          return response()->json(
              [
                  "mensagem" => "Responsável cadastrado com sucesso"
              ], 200
          );
      } catch (QueryException $e) {
          if ($e->errorInfo[1] == 1062) {
              return response()->json(
                  [
                      "mensagem" => "CPF duplicado: '05574916909'"
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

    
}
