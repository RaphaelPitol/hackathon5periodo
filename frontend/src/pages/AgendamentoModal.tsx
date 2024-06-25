import React, { useState } from 'react';
import axios from 'axios';
import '../styles/AgendamentoModal.css';

const AgendamentoModal: React.FC<{ isOpen: boolean, onClose: () => void, idoso: any }> = ({ isOpen, onClose, idoso }) => {
  const [dataHora, setDataHora] = useState('');
  const [status, setStatus] = useState('a vacinar');
  const [vacinaId, setVacinaId] = useState('');
  const [dataVacinacao, setDataVacinacao] = useState('');
  const [agenteId, setAgenteId] = useState('');
  const [message, setMessage] = useState('');
  const [error, setError] = useState('');

  if (!isOpen) return null;

  const handleAgendar = async () => {
    try {
      const response = await axios.post('http://127.0.0.1:8000/api/createagendamento', {
        data_hora: dataHora,
        status: status,
        idoso_id: idoso.id,
      });
      if (response.data.success) {
        setMessage('Agendamento realizado com sucesso!');
        onClose();
      } else {
        setError('Erro ao realizar agendamento.');
      }
    } catch (error) {
      setError('Erro ao realizar agendamento.');
    }
  };

  const handleVacinar = async () => {
    try {
      const response = await axios.post('http://127.0.0.1:8000/api/createvacinacao', {
        idoso_id: idoso.id,
        vacina_id: vacinaId,
        data_vacinacao: dataVacinacao,
        agente_id: agenteId,
      });
      if (response.data.success) {
        setMessage('Vacinação realizada com sucesso!');
        onClose();
      } else {
        setError('Erro ao realizar vacinação.');
      }
    } catch (error) {
      setError('Erro ao realizar vacinação.');
    }
  };

  return (
    <div className="modal-overlay">
      <div className="modal-content">
        <button className="close-button" onClick={onClose}>X</button>
        <h2>Marcar Agendamento ou Vacinação para {idoso.nome}</h2>
        {message && <p className="success-message">{message}</p>}
        {error && <p className="error-message">{error}</p>}
        <div className="form-group">
          <label>Data e Hora do Agendamento</label>
          <input type="datetime-local" value={dataHora} onChange={(e) => setDataHora(e.target.value)} />
        </div>
        <div className="form-group">
          <label>Status</label>
          <input type="text" value={status} onChange={(e) => setStatus(e.target.value)} />
        </div>
        <button className="button" onClick={handleAgendar}>Marcar Agendamento</button>
        <hr />
        <div className="form-group">
          <label>Vacina ID</label>
          <input type="text" value={vacinaId} onChange={(e) => setVacinaId(e.target.value)} />
        </div>
        <div className="form-group">
          <label>Data da Vacinação</label>
          <input type="date" value={dataVacinacao} onChange={(e) => setDataVacinacao(e.target.value)} />
        </div>
        <div className="form-group">
          <label>Agente ID</label>
          <input type="text" value={agenteId} onChange={(e) => setAgenteId(e.target.value)} />
        </div>
        <button className="button" onClick={handleVacinar}>Realizar Vacinação</button>
      </div>
    </div>
  );
};

export default AgendamentoModal;
