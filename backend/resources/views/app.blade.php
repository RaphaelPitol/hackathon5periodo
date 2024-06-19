<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>@yield('title')</title>
  <link rel="stylesheet" href="/css/styles.css">
  <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"> </script>
  <script nomodule src="https://unpkg .com/ionicons@7.1.0/dist/ionicons/ionicons.js"> </script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body class="bg-light">

  <nav class="navbar navbar-expand-lg " id="nav">
    <div class="container-fluid">
      <img src="/image/unialfa.png" alt="">
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
        <div class="navbar-nav">
          <a class="nav-link active" aria-current="page" href="/">Home</a>
          <a class="nav-link" href="{{route('products.index')}}">Produtos</a>
          <a class="nav-link" href="/cars">Carros</a>
          <a class="nav-link" href="/feature">Feature</a>
          <a class="nav-link" href="{{route('cep.consultacep')}}">Cep</a>
          <a class="nav-link" href="{{route('pokeapi')}}">Batalha</a>

        </div>
      </div>
    </div>
  </nav>
  <div class="container mt-3">
    @yield('content')
  </div>

  <footer>
    <div class="card-footer ">
      <p>&copy;Desenvolvido por Raphael Pitol
      <a class="link" href="//www.facebook.com/raphael.pitoljuliani.7/" target="_blank" rel="noopener noreferrer"><ion-icon name="logo-facebook"></ion-icon></a>
      <a class="link" href="http://" target="_blank" rel="noopener noreferrer"><ion-icon name="logo-instagram"></ion-icon></a>
      <a class="link" href="https://github.com/RaphaelPitol" target="_blank" rel="noopener noreferrer"><ion-icon name="logo-github"></ion-icon></a>
      </p>
    </div>
  </footer>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>

</html>