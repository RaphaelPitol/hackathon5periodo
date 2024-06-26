<?php

use App\Http\Controllers\AgendamentoController;
use App\Http\Controllers\AgenteSaudeController;
use App\Http\Controllers\IdosoController;
use App\Http\Controllers\IdosoVacinaController;
use App\Http\Controllers\ResponsavelController;
use App\Http\Controllers\VacinaController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/listrespo', [ResponsavelController::class, 'index']);
Route::get('/buscarespo/{id}', [ResponsavelController::class, 'show']);
Route::post('/login', [ResponsavelController::class, 'login']);
Route::post('/create', [ResponsavelController::class, 'create']);
Route::put('/updaterespo/{id}', [ResponsavelController::class, 'update']);
Route::delete('/deleterespo/{id}', [ResponsavelController::class, 'destroy']);

Route::post('/loginagente', [AgenteSaudeController::class, 'login']);
Route::get('/buscagente/{id}', [AgenteSaudeController::class, 'show']);
Route::post('/createagente', [AgenteSaudeController::class, 'create']);
Route::put('/updateagente/{id}', [AgenteSaudeController::class, 'update']);
Route::delete('/deleteagente/{id}' , [AgenteSaudeController::class, 'destroy']);

Route::get('/indexagenda', [AgendamentoController::class, 'index']);
Route::get('/showagenda/{id}', [AgendamentoController::class, 'show']);
Route::post('/createagendamento', [AgendamentoController::class, 'create']);
Route::put('/updateagendamento/{id}', [AgendamentoController::class, 'update']);
Route::delete('/deleteagenda/{id}' , [AgendamentoController::class, 'destroy']);

Route::get('/listidosos', [IdosoController::class, 'index']);
Route::get('/show/{id}', [IdosoController::class, 'show']);
Route::post('/createidoso', [IdosoController::class, 'create']);
Route::put('/updateidoso/{id}', [IdosoController::class, 'update']);
Route::delete('/deleteidoso/{id}' , [IdosoController::class, 'destroy']);
Route::get('/getidososrespo/{id}', [IdosoController::class, 'getIdosoResponsavel']);

Route::post('/createvacinacao', [IdosoVacinaController::class, 'create']);
Route::get('/idosovacina', [IdosoVacinaController::class, 'index']);
Route::get('/showvacinado/{id}', [IdosoVacinaController::class, 'showvacinado']);
Route::get('/shownaovacinado/{id}', [IdosoVacinaController::class, 'shownaovacinado']);
Route::delete('/deletevacinacao/{id}' , [IdosoVacinaController::class, 'destroy']);

Route::get('/index', [VacinaController::class, 'index']);
Route::get('/buscavacina/{id}', [VacinaController::class, 'show']);
Route::post('/createvacina', [VacinaController::class, 'create']);
Route::put('/updatevacina/{id}', [VacinaController::class, 'update']);
Route::delete('/deletevacina/{id}', [VacinaController::class, 'destroy']);