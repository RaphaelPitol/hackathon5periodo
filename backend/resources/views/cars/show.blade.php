@extends('layouts.app')
@section('title', 'Dados do Carro')
@section('content')

<div class="card">
  <div class="card-header">
    Detalhes do Carro {{$car->nome}}
  </div>
</div>
<div class="car-body">
  <p><strong>ID:</strong>{{$car->id}}</p>
  <p><strong>Nome:</strong>{{$car->nome}}</p>
  <p><strong>Modelo:</strong>{{$car->modelo}}</p>
  <p><strong>Ano Modelo:</strong>{{$car->ano_modelo}}</p>
  <br>
  <a class="btn btn-success" href="{{route('cars.index')}}">Voltar para lista de Carros!</a>
</div>

@endsection