<?php
use App\Http\Controllers\ConsultorController;
use Illuminate\Support\Facades\Route;


Route::post('/consultordata',[ConsultorController::class, 'getConsultorData']);