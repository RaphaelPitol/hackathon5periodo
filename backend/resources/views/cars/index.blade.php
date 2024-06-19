
@extends('layouts.app')
@section('title', 'Lista de Carros')
@section('content')


<table class="table table-hover">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Nome</th>
      <th scope="col">Marca</th>
      <th scope="col">Ano de Fabricação</th>
    </tr>
  </thead>
  <tbody>
    @foreach($cars as $car)
    <tr>
      <th scope="row">{{$car->id}}</th>
      <td><a href="{{route('cars.show', $car)}}" style="text-decoration: none;">{{$car->nome}}</a></td>
      <td>{{$car->marca}}</td>
      <td>{{\Carbon\Carbon::parse($car->ano_modelo)->format('d/m/Y')}}</td>
    </tr>
    @endforeach
  </tbody>
</table>
<a class="btn btn-success" href="{{route('cars.create')}}">Cadastrar</a>

@endsection