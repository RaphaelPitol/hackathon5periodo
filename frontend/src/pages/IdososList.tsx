import React from 'react';
import IdosoCard from './IdosoCard';
import '../styles/IdososList.css';

const IdososList: React.FC<{ idosos: any[], onClick: (idoso: any) => void }> = ({ idosos, onClick }) => {
  return (
    <div className="idosos-list">
      <h2>Lista de Idosos</h2>
      {Array.isArray(idosos) && idosos.length > 0 ? (
        idosos.map((idoso) => (
          <IdosoCard key={idoso.id} idoso={idoso} onClick={onClick} />
        ))
      ) : (
        <p>Nenhum idoso encontrado.</p>
      )}
    </div>
  );
};

export default IdososList;
