<?php

namespace App\Http\Controllers;

use App\Models\Idoso;
use Illuminate\Http\Request;

class IdosoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        $request = $request->except('_token');
        // dd($request);
        
        Idoso::create($request);

         return response()->json([
          'success' => 'Gravado com sucesso!',
          'responsavel' => $request
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
