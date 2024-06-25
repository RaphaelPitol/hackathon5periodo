import React from 'react';
import '../styles/VaccineScheduleModal.css';

const VaccineScheduleModal: React.FC<{ isOpen: boolean, onClose: () => void, idoso: any }> = ({ isOpen, onClose, idoso }) => {
  if (!isOpen) return null;

  const vaccines = [
    // Dados das vacinas específicos do idoso
    // Substitua pelos dados reais se tiver
  ];

  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <button className="close-button" onClick={onClose}>X</button>
        <h2>Quadro de Vacinas para {idoso.nome}</h2>
        <table>
          <thead>
            <tr>
              <th>IDADE</th>
              <th>VACINAS</th>
              <th>DOSES</th>
              <th>DOENÇAS EVITADAS</th>
            </tr>
          </thead>
          <tbody>
            {vaccines.map((vaccine, index) => (
              <tr key={index}>
                <td>{vaccine.age}</td>
                <td>{vaccine.vaccine}</td>
                <td>{vaccine.dose}</td>
                <td>{vaccine.diseases}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default VaccineScheduleModal;
