<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
	//user
        \App\Models\User::factory()->create([
           'name' => 'Admin',
           'email' => 'test@example.com',
           'password' => Hash::make('hardcoded'),
        ]);
	//company
	\App\Models\Company::factory()
	    ->count(10)
	    ->create();
	
	//employees, assigned to random company
	\App\Models\Employee::factory()
	    ->count(100)
	    ->create();
	
    }
}
