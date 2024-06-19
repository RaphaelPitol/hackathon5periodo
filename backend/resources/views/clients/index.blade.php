@extends('layouts.app')
@section('title', 'Lista de Clientes')
@section('content')
<h1>Lista de Clientes</h1>

<table class="table table-hover">
  <thead>
    <tr>
      <th>Id</th>
      <th>Nome</th>
      <th>Endereço</th>
      <th>Ações</th>
    </tr>
  </thead>
  <tbody>
    @foreach($clients as $client)
    <tr>
      <th>{{$client->id}}</th>
      <td>
        <a href="{{route('clients.show', $client)}}" style="text-decoration: none;">{{$client->nome}}</a>
      </td>
      <td>{{$client->endereco}}</td>
      <td style="display: flex; flex-direction: row;">
        <a href="{{route('clients.edit', $client)}}" class="btn btn-primary" style="margin-right: 5px;">Edit</a>
        <form action="{{route('clients.destroy', $client)}}" method="POST">
          @method('DELETE')
          @csrf
          <button class="btn btn-danger" type="submit" onclick="return confirm('Deseja realmente deletar?')">Delete</button>
        </form>
      </td>
    </tr>
    @endforeach
  </tbody>
</table>


@if($feature != null && $feature->valor == true)
<a class="btn btn-success" href="{{route('clients.create')}}">Cadastrar</a>

@else
<p>Usuario não esta autorizado a Cadastrar</p>

@endif
@endsection