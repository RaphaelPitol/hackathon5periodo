@extends('layouts.app')
@section('title', 'Cadastro de Produtos')
@section('content')

<form action="{{route('cep.consultacep')}}" method="POST">
  @csrf
  <h1>Consulta Cep</h1>
  <div class="form-group mx-sm-3 mb-2">
    <label for="cep" class="sr-only">Cep</label>
    <input type="number" class="form-control" id="cep" name="cep" placeholder="Digite seu Cep">
  </div>
  <button type="submit" class="btn btn-primary mb-2">Buscar</button>
</form>

@if (isset($erro))
<div class="alert alert-danger">
  <ul>
    
    <li>{{ $erro }}</li>
   
  </ul>
</div>
@endif

@if(!empty($endereco))
<div class="car-body">
  <p><strong>Rua: </strong>{{$endereco['logradouro']}}</p>
  <p><strong>Bairro: </strong>{{$endereco['bairro']}}</p>
  <p><strong>Cidade: </strong>{{$endereco['localidade']}}</p>
  <p><strong>Estado:</strong> {{$endereco['uf']}}</p>
  <br>
</div>
@endif



@endsection