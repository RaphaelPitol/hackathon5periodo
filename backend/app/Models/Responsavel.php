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

  public function setCpfAttribute($value)
    {
        $this->attributes['cpf'] = preg_replace('/\D/', '', $value);
    }

    // Mutator para remover a máscara do telefone
    public function setTelefoneAttribute($value)
    {
        $this->attributes['telefone'] = preg_replace('/\D/', '', $value);
    }
}
