<?php

namespace App\Http\Controllers;

use App\Models\Responsavel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Database\QueryException;

class ResponsavelController extends Controller

{

  public function login(Request $request)
{
    
    $data = Responsavel::where('cpf', $request->cpf)->first();


    if (!$data) {
        return response()->json(['error' => 'Usuário não encontrado'], 404);
    }

 
    if (Hash::check($request->password, $data->password)) {
       
        return response()->json(['success' => 'Login bem-sucedido']);
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
}
