<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use GuzzleHttp\Psr7\Response;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
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
        $employee = new Employee;

	$employee->first_name = $request->first_name;
	$employee->last_name = $request->last_name;
	$employee->email = $request->email;
	$employee->phone = $request->phone;
	$employee->company_id = $request->company_id;

	$employee->save();
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
	    "first_name" => "requiered",
	    "last_name" => "requiered",
	    "email" => "email:rfc,dns"
	]);

	$employee->first_name = $request->first_name;
	$employee->last_name = $request->last_name;
	$employee->email = $request->email;
	$employee->phone = $request->phone;
	$employee->company_id = $request->company_id;
        $employee->save();

	return back()->with('success', 'Employee updated successfully');
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

	return back()->with('success', 'Employee deleted successfully');
    }
}
