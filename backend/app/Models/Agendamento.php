<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Agendamento extends Model
{
    use HasFactory;

    protected $fillable = [
        'idoso_id',
        'data_hora',
        'status'
    ];
    public function idoso()
    {
        return $this->belongsTo(Idoso::class);
    }
}
