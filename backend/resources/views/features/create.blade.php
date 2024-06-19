@extends('layouts.app')
@section('title', 'Cadastro de Feature')
@section('content')

<form action="{{route('feature.store')}}" method="post">
  @csrf
  <h1>Gestão de feature</h1>
  <div class="mb-3">
    <label for="chave" class="form-label">Chave</label>
    <input type="text" name="chave" class="form-control" id="chave" placeholder="Digite o identificador">
  </div>
  <div class="mb-3">
    <label for="valor" class="form-label">Valor</label>
    <input type="number" class="form-control" name="valor" id="valor" placeholder=" 0 ou 1">
  </div>
  <div class="mb-3">
  <label for="descricao" class="form-label">Descrição</label>
  <input type="text" class="form-control" name="descricao" id="descricao" placeholder="Digite o descrição">
</div>

<button type="submit" class="btn btn-success">Cadastrar Feature</button>

</form>

@endsection