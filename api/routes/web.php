<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('welcome');
//});

Route::get('/', function () {
    return ['message' => 'ao-pdf service online!!'];
});

// \AOPDF\AOPDF::encode([['template' => 'https://github.com/alex-oliveira/ao-pdf/raw/master/example.pdf', 'params' => ['client_name' => 'ALEX DE OLIVEIRA', 'client_cpf' => '01877051195']]]);