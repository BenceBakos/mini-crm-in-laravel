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

use App\Models\Company;

/**
 * Upload company logo.
 *
 * @param  \Illuminate\Http\Request  $request
 * @param  int  $id
 * @return \Illuminate\Http\Response
 */
Route::post('/company/upload_logo/{id}', function (Request $request,int $id) {
    $company = Company::find($id);

    $request->validate([
	"logo" => "mimes:jpg,bmp,png",
    ]);

    $logo_path = $request->file('logo')->store('public/company_logos');
    $logo_path = str_replace("public/company_logos/","",$logo_path);
    $company->logo = $logo_path;

    $company->save();

    return $company;
})->middleware('auth:sanctum');

use App\Http\Controllers\CompanyController;
Route::apiResource('company',CompanyController::class);


use App\Http\Controllers\EmployeeController;
Route::apiResource('employee',EmployeeController::class);
