<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Vacina extends Model
{
    use HasFactory;

    public function idosos()
    {
        return $this->belongsToMany(Idoso::class, 'idoso_vacina');
    }
}
