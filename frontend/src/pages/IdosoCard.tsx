import React from 'react';
import '../styles/IdosoCard.css';

const IdosoCard: React.FC<{ idoso: any, onClick: (idoso: any) => void }> = ({ idoso, onClick }) => {
  return (
    <div className="idoso-card" onClick={() => onClick(idoso)}>
      <p>Nome: {idoso.nome}</p>
      <p>Data de Nascimento: {idoso.data_nascimento}</p>
      <p>Telefone: {idoso.telefone}</p>
      <p>Endereço: {idoso.endereco}, {idoso.numero}, {idoso.cidade}, {idoso.cep}</p>
      <p>Comorbidade: {idoso.comorbidade}</p>
    </div>
  );
};

export default IdosoCard;
