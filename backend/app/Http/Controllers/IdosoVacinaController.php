<?php

namespace App\Http\Controllers;

use App\Models\IdosoVacina;
use App\Models\Vacina;
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

        try {
          IdosoVacina::create($idosoVacina);
  
          return response()->json([
              "mensagem" => "Vacinado com sucessso",
              "idoso" => $idosoVacina
          ], 201);
          //code...
        } catch (\Throwable $th) {
          return response()->json([
            "mensagem" => "Verifique se todos os dados estão corretos!",
            "erro" => $th  ]);
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
    public function showvacinado(string $id)
    {
        $vacinado = IdosoVacina::with(['idoso', 'vacina', 'agente'])->where('idoso_id', $id)->get();

        // dd($vacinado);

        $response = $vacinado->map(function ($idosoVacinado) {
            return 
                // 'id' => $idosoVacinado->id,
                // 'idoso' => $idosoVacinado->idoso->nome, 
                $idosoVacinado->vacina->nome 
                // 'data_vacinacao' => $idosoVacinado->data_vacinacao,
                // 'agente' => $idosoVacinado->agente->nome, 
                // 'created_at' => $idosoVacinado->created_at,
                // 'updated_at' => $idosoVacinado->updated_at,
            ;
        });
    

        return response()->json([
            "vacinado" => $response
        ]);
        //
    }

    public function shownaovacinado(string $id)
{

    $todasVacinas = Vacina::all();

    $vacinasTomadas = IdosoVacina::with('vacina')
                                 ->where('idoso_id', $id)
                                 ->get()
                                 ->pluck('vacina_id')
                                 ->toArray();

    $vacinasNaoTomadas = $todasVacinas->filter(function ($vacina) use ($vacinasTomadas) {
        return !in_array($vacina->id, $vacinasTomadas);
    });


    $response = $vacinasNaoTomadas->map(function ($vacina) {
        return $vacina->nome;
    });

    return response()->json([
        "vacinas_nao_tomadas" => $response
    ]);
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
      $vacinacao = IdosoVacina::where('id', $id)->first();

      if (!$vacinacao) {
          return response()->json([
              "menssagen" => "Não existe na Base de Dados!"
          ]);
      }
    
      if ($vacinacao->id) {
        IdosoVacina::destroy($id);
  
          return response()->json([
              "menssagen" => "Deletado com sucesso"
          ]);
      }

    }
}
