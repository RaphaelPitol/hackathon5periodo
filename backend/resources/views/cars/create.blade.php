@extends('layouts.app')
@section('title', 'Cadastro de Carros')
@section('content')

<h1>Cadastro de Carros</h1>
<form action="{{route('cars.store')}}" method="post">
  @csrf

  <div class="mb-3">
    <label for="nome" class="form-label">Nome</label>
    <input type="text" name="nome" class="form-control" id="nome"
    
    placeholder="Digite o nome do carro">
  </div>
  <div class="mb-3">
    <label for="marca" class="form-label">Marca</label>
    <input type="text" class="form-control" name="marca" id="marca" placeholder="Digite a Marca">
  </div>
 
  <div class="mb-3">
    <label for="ano_modelo" class="form-label">Data de Fabricação</label>
    <input type="date" class="form-control" name="ano_modelo" id="ano_modelo" placeholder="ano_nodelo">
  </div>
 

  <button type="submit" class="btn btn-success">Cadastrar Carro</button>

</form>

@endsection