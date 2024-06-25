import React, { useState, useEffect } from 'react';
import axios from 'axios';
import '../styles/Responsavel.css';
import jwt from 'jsonwebtoken';
import { parseCookies } from 'nookies';
import IdososList from './IdososList';
import VaccineScheduleModal from './VaccineScheduleModal';

const Responsavel: React.FC = () => {
  const [showForm, setShowForm] = useState(false);
  const [name, setName] = useState('');
  const [birthDate, setBirthDate] = useState('');
  const [cpf, setCpf] = useState('');
  const [address, setAddress] = useState('');
  const [cep, setCep] = useState('');
  const [cidade, setCidade] = useState('');
  const [numero, setNumero] = useState('');
  const [comorbidade, setComorbidade] = useState('');
  const [phone, setPhone] = useState('');
  const [message, setMessage] = useState('');
  const [responsavelId, setResponsavelId] = useState<string | null>(null);
  const [idosos, setIdosos] = useState<any[]>([]);
  const [selectedIdoso, setSelectedIdoso] = useState<any | null>(null);

  useEffect(() => {
    const cookies = parseCookies();
    const token = cookies['painel1pitchau.token'];

    if (token) {
      try {
        const decodedToken = jwt.decode(token) as any;
        setResponsavelId(decodedToken?.sub?.id || null);
      } catch (error) {
        console.error('Token decoding failed:', error);
      }
    }
  }, []);

  useEffect(() => {
    const fetchIdosos = async () => {
      try {
        const response = await axios.get('http://127.0.0.1:8000/api/listidosos');
        if (response.data && Array.isArray(response.data.idosos)) {
          setIdosos(response.data.idosos);
        } else {
          setMessage('Erro ao buscar lista de idosos.');
        }
      } catch (error) {
        console.error('Erro ao buscar lista de idosos', error);
        setMessage('Erro ao buscar lista de idosos.');
      }
    };

    fetchIdosos();
  }, []);

  const handleButtonClick = () => {
    setShowForm(!showForm);
  };

  const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    const cookies = parseCookies();
    const token = cookies['painel1pitchau.token'];
    let decodedToken: any = null;

    if (token) {
      try {
        decodedToken = jwt.decode(token) as any;
        setResponsavelId(decodedToken?.sub?.id || null);
      } catch (error) {
        console.error('Token decoding failed:', error);
        setMessage('Erro ao decodificar token.');
        return;
      }
    }

    if (!responsavelId) {
      setMessage('Erro: ID do responsável não encontrado.');
      return;
    }

    try {
      const data = {
        nome: name,
        data_nascimento: birthDate,
        telefone: phone,
        cep: cep,
        cidade: cidade,
        endereco: address,
        numero: numero,
        comorbidade: comorbidade,
        responsavel_id: decodedToken?.sub?.id // Usa o ID do responsável decodificado do token
      };

      console.log('Sending data to server:', data);

      const response = await axios.post('http://127.0.0.1:8000/api/createidoso', data, {
        withCredentials: true
      });

      console.log('Server response:', response.data);

      if (response.data.success) {
        setMessage('Idoso adicionado com sucesso!');
        setName('');
        setBirthDate('');
        setCpf('');
        setAddress('');
        setCep('');
        setCidade('');
        setNumero('');
        setComorbidade('');
        setPhone('');
        setShowForm(false);

        const fetchIdosos = async () => {
          try {
            const response = await axios.get('http://127.0.0.1:8000/api/listidosos');
            if (response.data && Array.isArray(response.data.idosos)) {
              setIdosos(response.data.idosos);
            } else {
              setMessage('Erro ao buscar lista de idosos.');
            }
          } catch (error) {
            console.error('Erro ao buscar lista de idosos', error);
            setMessage('Erro ao buscar lista de idosos.');
          }
        };
        fetchIdosos();
      } else {
        setMessage('Erro ao adicionar idoso.');
      }
    } catch (error: any) {
      console.error('Erro ao tentar adicionar idoso', error);
      setMessage('Erro ao tentar adicionar idoso.');
    }
  };

  const handleIdosoClick = (idoso: any) => {
    setSelectedIdoso(idoso);
  };

  const handleCloseModal = () => {
    setSelectedIdoso(null);
  };

  return (
    <div className="responsavel-container">
      <h1>Bem-vindo, Responsável!</h1>
      <button onClick={handleButtonClick} className="btn-add-idoso">
        {showForm ? 'Fechar Formulário' : 'Adicionar Idoso'}
      </button>
      {message && <p className="message">{message}</p>}
      {showForm && (
        <form className="add-idoso-form" onSubmit={handleSubmit}>
          <div className="form-group">
            <label>ID do Responsável:</label>
            <input
              type="text"
              className="form-control"
              value={responsavelId || ''}
              readOnly
            />
          </div>
          <div className="form-group">
            <label>Nome do Idoso:</label>
            <input
              type="text"
              className="form-control"
              value={name}
              onChange={(e) => setName(e.target.value)}
              required
            />
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Data de Nascimento:</label>
              <input
                type="date"
                className="form-control"
                value={birthDate}
                onChange={(e) => setBirthDate(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Telefone:</label>
              <input
                type="text"
                className="form-control"
                value={phone}
                onChange={(e) => setPhone(e.target.value)}
                required
              />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>CEP:</label>
              <input
                type="text"
                className="form-control"
                value={cep}
                onChange={(e) => setCep(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Cidade:</label>
              <input
                type="text"
                className="form-control"
                value={cidade}
                onChange={(e) => setCidade(e.target.value)}
                required
              />
            </div>
          </div>
          <div className="form-row">
            <div className="form-group">
              <label>Endereço:</label>
              <input
                type="text"
                className="form-control"
                value={address}
                onChange={(e) => setAddress(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Número:</label>
              <input
                type="text"
                className="form-control"
                value={numero}
                onChange={(e) => setNumero(e.target.value)}
                required
              />
            </div>
          </div>
          <div className="form-group">
            <label>Comorbidade:</label>
            <input
              type="text"
              className="form-control"
              value={comorbidade}
              onChange={(e) => setComorbidade(e.target.value)}
            />
          </div>
          <button type="submit" className="btn-submit">Adicionar</button>
        </form>
      )}
      <IdososList idosos={idosos} onClick={handleIdosoClick} />
      <VaccineScheduleModal isOpen={selectedIdoso !== null} onClose={handleCloseModal} idoso={selectedIdoso} />
    </div>
  );
};

export default Responsavel;
