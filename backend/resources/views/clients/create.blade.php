@extends('layouts.app')
@section('title', 'Novo Cliente')
@section('content')


<form action="{{route('clients.store')}}" method="POST">
  @csrf
  <h1>Cadastro de Cliente</h1>
  <div class="mb-3">
    <label for="nome" class="form-label">Nome</label>
    <input type="text" name="nome" class="form-control" id="nome" placeholder="Digite o nome">
  </div>
  <div class="mb-3">
    <label for="endereco" class="form-label">Endereço</label>
    <input type="text" class="form-control" name="endereco" id="endereco" placeholder="Digite o endereço">
  </div>
  <div class="mb-3">
    <label for="observacao" class="form-label">Observação</label>
    <textarea class="form-control" name="observacao" id="observacao" rows="3"></textarea>
  </div>
  
  
  @if($feature != null && $feature->valor == true)
  <button type="submit" class="btn btn-success">Cadastrar Cliente</button>
  @else
  <h1>Não esta Autorizado a cadastrar</h1>
  @endif
  </form>





@endsection