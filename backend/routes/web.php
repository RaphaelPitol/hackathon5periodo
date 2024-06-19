<?php

use App\Http\Controllers\BattleController;
use App\Http\Controllers\BuscaCepController;
use App\Http\Controllers\CarController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\FeatureFlagController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\SiteController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;


// Route::get('/service/{id}', [SiteController::class, 'index']);

Route::get('/welcome', function(){
  return view('welcome');
});
