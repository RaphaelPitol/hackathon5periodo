<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vacina extends Model
{
    use HasFactory;

    protected $fillable = [
        'nome',
        'marca',
        'descricao',
        'validade'
    ];

    public function idosos()
    {
        return $this->belongsToMany(Idoso::class, 'idoso_vacina');
    }
}
