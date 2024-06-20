<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('vacinas', function (Blueprint $table) {
            $table->id();
            $table->string('nome');
            $table->string('marca');
            $table->date('validade');
            $table->timestamps();
        });

        Schema::create('idoso_vacina', function (Blueprint $table) {
          $table->id();
          $table->foreignId('idoso_id')->constrained()->onDelete('cascade');
          $table->foreignId('vacina_id')->constrained()->onDelete('cascade');
          $table->timestamps();
      });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('idoso_vacina');
        Schema::dropIfExists('vacinas');
    }
};
