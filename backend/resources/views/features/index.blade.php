
@extends('layouts.app')
@section('title', 'Lista Feature')
@section('content')


<table class="table table-hover">
  <h1>Listagem de FeatureFlags</h1>
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Chave</th>
      <th scope="col">Valor</th>
      <th scope="col">Descrição</th>
      <th scope="col">Ações</th>
      
    </tr>
  </thead>
  <tbody>
    @foreach($features as $feature)
    <tr>
      <th scope="row">{{$feature->id}}</th>
      <td>{{$feature->chave}}</></td>
      <td>{{$feature->valor}}</td>
      <td>{{$feature->descricao}}</td>
      <td>
      <a href="{{route('feature.edit', $feature)}}" class="btn btn-primary" style="margin-right: 5px;">Edit</a>
      </td>
    </tr>
    @endforeach
  </tbody>
</table>
<a class="btn btn-success" href="{{route('feature.create')}}">Cadastrar</a>

@endsection