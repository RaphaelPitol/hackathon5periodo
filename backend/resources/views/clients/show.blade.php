@extends('layouts.app')
@section('title', 'Dados do Cliente')
@section('content')
<h1>Dados do Cliente</h1>

<div class="card">
  <div class="card-header">
    Detalhes do Cliente {{$client->nome}}
  </div>
</div>
<div class="car-body">
  <p><strong>ID:</strong>{{$client->id}}</p>
  <p><strong>Nome:</strong>{{$client->nome}}</p>
  <p><strong>Endereço:</strong>{{$client->endereco}}</p>
  <p><strong>Observação:</strong>{{$client->observacao}}</p>
  <br>
  <a class="btn btn-success" href="{{route('clients.index')}}">Voltar para lista de Clientes!</a>
</div>
@endsection