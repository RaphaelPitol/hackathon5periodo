@extends('layouts.app')
@section('title', 'Edição')
@section('content')

<form action="{{route('clients.update', $client)}}" method="POST">
  @csrf
  @method('PUT')
  <h1>Edição de Cliente</h1>
  <div class="mb-3">
    <label for="nome" class="form-label">Nome</label>
    <input type="text" name="nome" class="form-control" id="nome" value="{{$client->nome}}" placeholder="Digite o nome">
  </div>
  <div class="mb-3">
    <label for="endereco" class="form-label">Endereço</label>
    <input type="text" class="form-control" name="endereco" id="endereco" value="{{$client->endereco}}" placeholder="Digite o endereço">
  </div>
  <div class="mb-3">
  <label for="observacao" class="form-label">Observação</label>
  <textarea class="form-control" name="observacao" id="observacao" rows="3">{{$client->observacao}}</textarea>
</div>

<button type="submit" class="btn btn-success">Editar Cliente</button>

</form>

@endsection