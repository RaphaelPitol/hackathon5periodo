<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Mockery\Undefined;

class BuscaCepController extends Controller
{
  public function consultacep(Request $request){

    $cep = $request->input('cep');
   // echo strlen($cep);
    if(strlen($cep) != 8) {
      $erro = "Deve ter 8 numeros!";
          return view('cep.index',[
            "erro" => $erro
          ]);
    }
    //dd();
        
        $response = Http::withOptions(['verify' => false])->get('https://viacep.com.br/ws/' . $cep . '/json');
       
        
        $endereco = $response->json();
        
     
        // dd($endereco);
        if(!array_key_exists('erro', $endereco)){
          return view('cep.index',[
            "endereco" => $endereco
          ]);

        }

        if($endereco == null){
          $erro = "Verifique sua conexão com a Internet.";
          return view('cep.index',[
            "erro" => $erro
          ]);
        }

        if($endereco['erro']){
          $erro = "Cep Não encontrado";
          return view('cep.index',[
            "erro" => $erro
          ]);
        }
  }
    /**
     * Display a listing of the resource.
     * 
     */
    public function index()
    {
      return view('cep.index');
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        
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
