<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Responsavel extends Model
{
    use HasFactory;
    protected $fillable = [
      'nome',
      'telefone',
      'cpf',
      'password',
  ];

  public function idosos()
  {
      return $this->hasMany(Idoso::class);
  }
}
