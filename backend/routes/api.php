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
Route::post('/login', [ResponsavelController::class, 'login']);
Route::post('/loginagente', [AgenteSaudeController::class, 'login']);
Route::post('/create', [ResponsavelController::class, 'create']);
Route::post('/createidoso', [IdosoController::class, 'create']);
Route::get('/show/{id}', [IdosoController::class, 'show']);
Route::post('/createvacina', [VacinaController::class, 'create']);
Route::post('/createagente', [AgenteSaudeController::class, 'create']);
Route::post('/createagendamento', [AgendamentoController::class, 'create']);
Route::post('/createvacinacao', [IdosoVacinaController::class, 'create']);
Route::get('/index', [VacinaController::class, 'index']);
Route::put('/updateidoso/{id}', [IdosoController::class, 'update']);
Route::delete('/deleteidoso/{id}' , [IdosoController::class, 'destroy']);