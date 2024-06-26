<?php

namespace App\Http\Controllers;

use App\Models\Vacina;
use Illuminate\Http\Request;

class VacinaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $vacinas = Vacina::all();

        return response()->json(["vacinas" => $vacinas]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $request = $request->except('_token');
        // dd($request);
        
        Vacina::create($request);

         return response()->json([
          'success' => 'Gravado com sucesso!',
          'responsavel' => $request
        ]);
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
      $vacina = Vacina::find($id);

      if(!$vacina){
        return response()->json(["menssage" => "Nenhum registro encontrado!"]);
      }

      return response()->json([$vacina]);
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
        $vacina = Vacina::find($id);

        if (!$vacina) {
            return response()->json([
                "mensagem" => "Erro ao Buscar!"
            ]);
        }

        $vacina->nome = $request->nome;
        $vacina->marca = $request->marca;
        $vacina->descricao = $request->descricao;
        $vacina->validade = $request->validade;

        $vacina->save();

        return response()->json([
            "mensagem" => "Salvo com sucesso"
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $vacina = Vacina::where('id', $id)->first();

        if (!$vacina) {
            return response()->json([
                "menssagen" => "Não existe na Base de Dados!"
            ]);
        }
      
        if ($vacina->id) {
            Vacina::destroy($id);
    
            return response()->json([
                "menssagen" => "Deletado com sucesso"
            ]);
        }

    }
}
