<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Idoso extends Model
{
    use HasFactory;

    public function responsavel()
    {
        return $this->belongsTo(Responsavel::class);
    }

    public function vacinas()
    {
        return $this->belongsToMany(Vacina::class, 'idoso_vacina');
    }

    public function agendamentos()
    {
        return $this->hasMany(Agendamento::class);
    }
}
