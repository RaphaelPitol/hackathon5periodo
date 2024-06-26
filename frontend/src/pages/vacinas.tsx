import React, { useEffect, useState } from 'react';
import { useRouter } from 'next/router';
import axios from 'axios';
import '../styles/Vacinas.css';

const Vacinas = () => {
  const router = useRouter();
  const { idosoId } = router.query;

  const [vacinas, setVacinas] = useState([]);

  useEffect(() => {
    const fetchVacinas = async () => {
      if (!idosoId) return;
      try {
        const response = await axios.get(`http://127.0.0.1:8000/api/index/`);
        setVacinas(response.data.vacinas);
      } catch (error) {
        console.error('Erro ao buscar vacinas:', error);
      }
    };

    fetchVacinas();
  }, [idosoId]);

  return (
    <div className="vacinas-container">
      <h1>Vacinas do Idoso</h1>
      <div className="vacinas-grid">
        {vacinas.map((vacina) => (
          <div key={vacina.id} className="vacina-card">
            <p>Nome: {vacina.nome}</p>
            <p>Marca: {vacina.marca}</p>
            <p>Descrição: {vacina.descricao}</p>
            <p>Validade: {vacina.validade}</p>
          </div>
        ))}
      </div>
    </div>
  );
};

export default Vacinas;
