<?php

namespace App\Http\Controllers;

use App\Models\Agendamento;
use Illuminate\Http\Request;

class AgendamentoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $agenda = Agendamento::all();

        return response()->json([
            "mensagem" => "Lista de Agendamentos",
            "agenda" => $agenda
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $request = $request->except('_token');


      try {
        $agendamento = Agendamento::create($request);
      } catch (\Throwable $th) {
        return response()->json([
            'Erro' => 'Verifique os dados informados!',
            "erro" => $th
          ]);
      }

        
        return response()->json([
            'success' => 'Gravado com sucesso!',
            'responsavel' => $agendamento
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
        try {
            $agenda = Agendamento::find($id);
            $agenda->data_hora = $request->data_hora;
            $agenda->status = $request->status;
            $agenda->idoso_id = $request->idoso_id;
    
            $agenda->save();
    
            return response()->json([
                "mensagem" => "Atualizado"
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                "mensagem" => "Erro ao editar",
                "erro" => $th
            ]);
        }




    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
      
        $agenda = Agendamento::where('id', $id)->first();

        if (!$agenda) {
            return response()->json([
                "menssagen" => "Não existe na Base de Dados!"
            ]);
        }
      
        if ($agenda->id) {
          Agendamento::destroy($id);
    
            return response()->json([
                "menssagen" => "Deletado com sucesso"
            ]);
        }

    }
}
