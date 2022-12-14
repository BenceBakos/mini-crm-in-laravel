<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use App\Models\Company;
use Illuminate\Http\Request;
use Symfony\Component\HttpKernel\Exception\HttpException;
use Illuminate\Validation\ValidationException;

class EmployeeController extends Controller
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
	    Employee::all()
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
	    "first_name" => "required",
	    "last_name" => "required",
	    "company_id" => "required",
	]);

	if (!Company::where("id", $request->company_id)->exists()){
	    return response()->json([
		"message" => "Selected company does not exitst"
	    ], 405);

	}

        $employee = new Employee;

	$employee->first_name = $request->first_name;
	$employee->last_name = $request->last_name;
	$employee->email = $request->email;
	$employee->phone = $request->phone;
	$employee->company_id = $request->company_id;

	$employee->save();

	return $employee;
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function show(Employee $employee)
    {
        return response()->json($employee);
    }


    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Employee $employee)
    {
	$request->validate([
	    "first_name" => "required",
	    "last_name" => "required",
	    "company_id" => "required",
	]);

	if (!Company::where("id", $request->company_id)->exists()){
	    return response()->json([
		"message" => "Selected company does not exitst"
	    ], 405);

	}

	$employee->first_name = $request->first_name;
	$employee->last_name = $request->last_name;
	$employee->email = $request->email;
	$employee->phone = $request->phone;
	$employee->company_id = $request->company_id;
        $employee->save();

	return $employee;
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Employee  $employee
     * @return \Illuminate\Http\Response
     */
    public function destroy(Employee $employee)
    {
        $employee->delete();

	return response()->json(null, 204);
    }
}
