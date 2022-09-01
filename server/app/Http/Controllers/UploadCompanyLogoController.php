<?php

namespace App\Http\Controllers;

use App\Models\Company;
use Illuminate\Http\Request;

class UploadCompanyLogoController extends Controller
{
    public function upload(Request $request,int $id)
    {
	$company = Company::find($id);

	$request->validate([
	    "logo" => "mimes:jpg,bmp,png",
	]);

	$logo_path = $request->file('logo')->store('public/company_logos');
	$logo_path = str_replace("public/company_logos/","",$logo_path);
	$company->logo = $logo_path;

	$company->save();

	return $company;
    }

}
