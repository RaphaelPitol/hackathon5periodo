@extends('layouts.app')
@section('title', 'Edição de Feature')
@section('content')

<form action="{{route('feature.update', $feature)}}" method="post">
  @csrf
  @method('PUT')
  <h1>Gestão de feature</h1>
  <div class="mb-3">
    <label for="chave" class="form-label">Chave</label>
    <input type="text" name="chave" class="form-control" id="chave" value="{{$feature->chave}}" placeholder="Digite o identificador">
  </div>
  <div class="mb-3">
    <label for="valor" class="form-label">Valor</label>
    <input type="number" class="form-control" name="valor" id="valor" value="{{$feature->valor}}" placeholder=" 0 ou 1">
  </div>
  <div class="mb-3">
  <label for="descricao" class="form-label">Descrição</label>
  <input type="text" class="form-control" name="descricao" id="descricao" value="{{$feature->descricao}}" placeholder="Digite o descrição">
</div>

<button type="submit" class="btn btn-success">Editar Feature</button>

</form>

@endsection