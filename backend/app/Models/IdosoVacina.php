<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class IdosoVacina extends Model
{
    use HasFactory;

    protected $table = 'idoso_vacina';

    protected $fillable = [
        'idoso_id',
        'vacina_id',
        'data_vacinacao',
        'agente_id'
    ];
}
