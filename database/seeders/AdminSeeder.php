<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB as FacadesDB;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        FacadesDB::table('users')->insert([
            'name' => 'Jobel Golde',
            'email' => 'jobelgolde12@gmail.com',
            'email_verified_at' => now(), 
            'password' => Hash::make('iloveu3000'),
            'role' => 'admin',
        ]);
    }
}
