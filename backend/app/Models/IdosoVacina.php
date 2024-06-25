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

    public function idoso()
    {
        return $this->belongsTo(Idoso::class);
    }

    // Defina a relação com o modelo Vacina
    public function vacina()
    {
        return $this->belongsTo(Vacina::class);
    }

    // Defina a relação com o modelo Agente
    public function agente()
    {
        return $this->belongsTo(Agente::class);
    }
}
