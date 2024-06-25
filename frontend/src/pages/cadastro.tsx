import React, { useState } from 'react';
import axios from 'axios';
import Layout from '../components/Layout';
import '../styles/global.css';

const Cadastro: React.FC = () => {
    const [formData, setFormData] = useState({
        nome: '',
        telefone: '',
        cpf: '',
        password: ''
    });

    const [message, setMessage] = useState('');

    const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        setFormData({ ...formData, [name]: value });
    };

    const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        try {
            const response = await axios.post('http://127.0.0.1:8000/api/create', formData);
            setMessage(response.data.mensagem);
        } catch (error) {
            if (axios.isAxiosError(error) && error.response) {
                setMessage(error.response.data.mensagem);
            } else {
                setMessage('Erro ao enviar os dados.');
            }
        }
    };

    return (
        <Layout>
            <div className="container">
                <h1>Cadastro de responsável</h1>
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label htmlFor="nome">Nome:</label>
                        <input
                            type="text"
                            id="nome"
                            name="nome"
                            value={formData.nome}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="telefone">Telefone:</label>
                        <input
                            type="text"
                            id="telefone"
                            name="telefone"
                            value={formData.telefone}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="cpf">CPF:</label>
                        <input
                            type="text"
                            id="cpf"
                            name="cpf"
                            value={formData.cpf}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label htmlFor="password">Senha:</label>
                        <input
                            type="password"
                            id="password"
                            name="password"
                            value={formData.password}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <button type="submit">Cadastrar</button>
                </form>
                {message && <p className="message">{message}</p>}
            </div>
        </Layout>
    );
};

export default Cadastro;
