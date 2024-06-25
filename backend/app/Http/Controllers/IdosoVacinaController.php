<?php

namespace App\Http\Controllers;

use App\Models\IdosoVacina;
use Illuminate\Http\Request;

class IdosoVacinaController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
      $idososVacinados = IdosoVacina::with(['idoso', 'vacina', 'agente'])->get();

    $response = $idososVacinados->map(function ($idosoVacinado) {
        return [
            'id' => $idosoVacinado->id,
            'idoso' => $idosoVacinado->idoso->nome, 
            'vacina' => $idosoVacinado->vacina->nome, 
            'data_vacinacao' => $idosoVacinado->data_vacinacao,
            'agente' => $idosoVacinado->agente->nome, 
            'created_at' => $idosoVacinado->created_at,
            'updated_at' => $idosoVacinado->updated_at,
        ];
    });

    return response()->json([
        'mensagem' => 'Idosos Vacinados',
        'idosoVacinado' => $response
    ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        //
        $idosoVacina = $request->except('_token');

        IdosoVacina::create($idosoVacina);

        return response()->json([
            "mensagem" => "Vacinado com sucessso",
            "idoso" => $idosoVacina
        ], 201);
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
