<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\DB;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Employee>
 */
class EmployeeFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
	$companyIDs = DB::table('companies')->pluck('id')->toArray();

        return [
	    "first_name" => fake()->firstName(),
	    "last_name" => fake()->lastName(),
	    "email"=>fake()->email(),
	    "phone"=>fake()->phoneNumber(),
	    "company_id" => $companyIDs[array_rand($companyIDs)]
        ];
    }
}
