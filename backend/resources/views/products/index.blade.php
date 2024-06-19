@extends('layouts.app')
@section('title', 'Lista de Produtos')
@section('content')

<table class="table table-hover">
  <h1>Lista de Produtos</h1>
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">Nome</th>
      <th scope="col">Quantidade</th>
      <th scope="col">Preço</th>
      <th scope="col">Ações</th>
    </tr>
  </thead>
  <tbody>
    @foreach($products as $product)
    <tr>
      <th scope="row">{{$product->id}}</th>
      <td><a href="{{route('products.show', $product)}}" style="text-decoration: none;">{{$product->nome}}</a></td>
      <td>{{$product->qtd_product}}</td>
      <td>R$ {{number_format($product->preco, 2, ',', '.')}}</td>

      <td style="display: flex; flex-direction: row;">
      <a href="{{route('products.edit', $product)}}" class="btn btn-primary" style="margin-right: 5px;">Edit</a>
      <form action="{{route('products.destroy', $product)}}" method="post">
        @method('DELETE')
        @csrf
        <button class="btn btn-danger" type="submit" onclick="return confirm('Deseja realmente deletar?')">Delete</button>
      </form>
      </td>
    </tr>
    @endforeach
  </tbody>
</table>

<a class="btn btn-success" href="{{route('products.create')}}">Cadastrar</a>


@endsection