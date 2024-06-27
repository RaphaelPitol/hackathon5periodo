<?php

namespace App\Http\Controllers;

use App\Models\Idoso;
use DateTime;
use Illuminate\Http\Request;

class IdosoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
       $idosos = Idoso::all();

        return response()->json([
            "menssagem" => "Todos Idosos",
            "idosos" => $idosos
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
      $data = new DateTime($request->data_nascimento);
      
      $idoso = new Idoso();
      $idoso->nome = $request->nome;
      $idoso->data_nascimento = $data->format('Y-m-d');
      $idoso->telefone = preg_replace('/\D/', '', $request->telefone);
      $idoso->cep = preg_replace('/\D/', '', $request->cep);
      $idoso->cidade = $request->cidade;
      $idoso->endereco = $request->endereco;
      $idoso->numero = $request->numero;
      $idoso->comorbidade = $request->comorbidade;
      $idoso->responsavel_id = $request->responsavel_id;
      $idoso->save();
      // error_log($idoso);
      
         return response()->json([
          'success' => 'Gravado com sucesso!',
          'idoso' => $idoso
        ]);
    }

   
    public function show(string $id)
    {
        $idoso = Idoso::find($id);

        if(!$idoso){
          return response()->json(["menssage" => "Nenhum registro encontrado!"]);
        }

        return response()->json([$idoso]);
    }

   
    public function getIdosoResponsavel(string $id)
    {
    
      $idosos = Idoso::where('responsavel_id', $id)->get();
      

        if ($idosos->isEmpty()) {
            return response()->json([
                "menssagen" => "Não existe Idosos para este Responsavel!"
            ]);
        }
      
     

            return response()->json([
                "menssagen" => "Lista de Idosos",
                "idosos" => $idosos
            ]);
        
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
       

        $idoso = Idoso::find($id);

        $idoso->nome = $request->nome;
        $idoso->data_nascimento = $request->data_nascimento;
        $idoso->telefone = $request->telefone;
        $idoso->cep = $request->cep;
        $idoso->cidade = $request->cidade;
        $idoso->endereco = $request->endereco;
        $idoso->numero = $request->numero;
        $idoso->comorbidade = $request->comorbidade;
        $idoso->responsavel_id = $request->responsavel_id;

        $idoso->save();

        return response()->json([
            "mensagem" => "Atualizado",
            "idoso" => $idoso]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
      
       
        $idoso = Idoso::where('id', $id)->first();

        if (!$idoso) {
            return response()->json([
                "menssagen" => "Idosos Não existe na Base de Dados!"
            ]);
        }
      
        if ($idoso->id) {
            Idoso::destroy($id);
    
            return response()->json([
                "menssagen" => "Deletado com sucesso"
            ]);
        }

        
    }
}
