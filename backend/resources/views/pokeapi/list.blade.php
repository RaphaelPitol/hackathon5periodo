@extends('layouts.app')
@section('title', 'Batalha de Pokemon')
@section('content')

<div class="container mt-5">
        <!-- <form action="submit_form.php" method="post">
        
            
            <button type="submit" class="btn btn-primary">Enviar</button>
        </form> -->
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
    </div>
  @endsection