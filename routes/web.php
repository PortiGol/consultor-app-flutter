<?php
use App\Http\Controllers\ConsultorController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::post('/consultordata',[ConsultorController::class, 'getConsultorData']); // ruta para hacer post 
