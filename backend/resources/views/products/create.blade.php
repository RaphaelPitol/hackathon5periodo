@extends('layouts.app')
@section('title', 'Cadastro de Produtos')
@section('content')

<form action="{{route('products.store')}}" method="post">
  @csrf
  <h1>Cadastro de Produtos</h1>
  <div class="mb-3">
    <label for="nome" class="form-label">Nome</label>
    <input type="text" name="nome" class="form-control" id="nome" placeholder="Digite o nome">
  </div>
  <div class="mb-3">
    <label for="qtd_product" class="form-label">Quantidade</label>
    <input type="text" class="form-control" name="qtd_product" id="qtd_product" placeholder="Digite a quantidade">
  </div>
  <div class="mb-3">
  <label for="preco" class="form-label">Preço</label>
  <input type="text" class="form-control" name="preco" id="preco" placeholder="Digite o preço">
</div>

<button type="submit" class="btn btn-success">Cadastrar Produto</button>

</form>

@endsection