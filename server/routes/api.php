<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//authentication
use App\Http\Controllers\AuthenticationController;
Route::post('/login', [AuthenticationController::class, 'login'])->name("login");
Route::post('/logout', [AuthenticationController::class, 'logout'])->middleware('auth:sanctum');

//company CRUD
use App\Http\Controllers\CompanyController;
Route::apiResource('company',CompanyController::class);

//company logo
use App\Http\Controllers\UploadCompanyLogoController;
Route::post('/company/upload_logo/{id}', [UploadCompanyLogoController::class, 'upload'])->middleware('auth:sanctum');

//employee CRUD
use App\Http\Controllers\EmployeeController;
Route::apiResource('employee',EmployeeController::class);
