@extends('layouts.app')
@section('title', 'Detalhes do produto')
@section('content')

<div class="card">
  <div class="card-header">
    Detalhes do Produto {{$product->nome}}
  </div>
</div>
<div class="car-body">
  <p><strong>ID: </strong>{{$product->id}}</p>
  <p><strong>Nome: </strong>{{$product->nome}}</p>
  <p><strong>Quantidade: </strong>{{$product->qtd_product}}</p>
  <p><strong>Preço:</strong> R$ {{number_format($product->preco, 2, ',', '.')}}</p>
  <br>
  <a class="btn btn-success" href="{{route('products.index')}}">Voltar para lista de Produtos!</a>
</div>
@endsection