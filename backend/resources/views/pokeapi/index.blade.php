@extends('layouts.app')
@section('title', 'Batalha de Pokemon')
@section('content')

<h1>Pokémon Battle</h1>
<form action="{{route('battle')}}" method="post">
  @csrf
  <div class="form-group mx-sm-3 mb-2">
       <div class="form-group">
                <label for="select1">Escolha o 1ºPokemon:</label>
                
                <select id="select1" name="option1" class="form-control">
                  <option value="opcao1">-------</option>
                  @foreach ($data as $pokemon )
                  <option value="{{$pokemon['name']}}">{{$pokemon['name']}}</option>
                @endforeach
                  </select>
            </div>
            
            <div class="form-group">
                <label for="select2">Escolha o 2ºPokemon:</label>
                <select id="select2" name="option2" class="form-control">
                <option value="opcao1">-------</option>
                  @foreach ($data as $pokemon )
                  <option value="{{$pokemon['name']}}">{{$pokemon['name']}}</option>
                @endforeach
                </select>
            </div>

  <br>
  <button type="submit" class="btn btn-primary mb-2">Battle!</button>
</form>

@if (isset($erro))
<div class="alert alert-danger">
  <ul>
    <li>{{ $erro }}</li>
  </ul>
</div>
@endif

@if(!empty($result))
<div class="car-body">
  <h2>{{$result}}</h2>
  <br>
</div>
@endif

@endsection