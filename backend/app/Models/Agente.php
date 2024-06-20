<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agente extends Model
{
    use HasFactory;

    protected $fillable = [
        'nome',
        'telefone',
        'cpf',
        'password',
    ];

    public function vacinacao()
  {
      return $this->hasMany(Vacina::class);
  }

  public function idosoVacinas()
    {
        return $this->hasMany(IdosoVacina::class);
    }
}
