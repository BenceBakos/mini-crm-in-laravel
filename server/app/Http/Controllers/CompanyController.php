<?php

namespace App\Http\Controllers;

use App\Models\Company;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;

class CompanyController extends Controller
{

    public function __construct()
    {
	$this->middleware('auth:sanctum',['only'=>[
	    'store',
	    'update',
	    'destroy',
	]]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
	return response()->json(
	    Company::withCount('employees')->get()
	);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
	$request->validate([
	    "name" => "required",
	]);

        $company = new Company;

	$company->name = $request->name;
	$company->email = $request->email;
	$company->website = $request->website;
	$company->logo = "";
	
	$company->save();

	return $company;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Company  $company
     * @return \Illuminate\Http\Response
     */
    public function show(Company $company)
    {
        return response()->json($company->load(['employees']));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Company  $company
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Company $company)
    {
	$request->validate([
	    "name" => "required",
	]);

	$company->name = $request->name;
	$company->email = $request->email;
	$company->website = $request->website;

        $company->save();

	return $company;

    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Company  $company
     * @return \Illuminate\Http\Response
     */
    public function destroy(Company $company)
    {
	//check for employees are present
	if ($company->employees()->get()->count() !== 0){

	    return response()->json([
		"message" => "Please delete or move all employees of the company"
	    ], 405);
	}

        $company->delete();

	return response()->json(null, 204);
    }
}
