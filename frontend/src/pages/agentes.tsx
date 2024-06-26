"use client";
import { SyntheticEvent, useState, useEffect } from "react";
import { useRouter } from 'next/router';
import axios from "axios";
import { Toast } from "@/app/componentes/Toast";
import { Loading } from "@/app/componentes/Loading";
import '../styles/global.css';
import AgendamentoModal from "./AgendamentoModal";

const Agentes: React.FC = () => {
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState("");
    const [message, setMessage] = useState("");
    const [showForm, setShowForm] = useState(false); // Estado para controlar a visibilidade do formulário
    const [idosos, setIdosos] = useState<any[]>([]);
    const [showIdosos, setShowIdosos] = useState(false); // Estado para controlar a visibilidade da lista de idosos
    const [selectedIdoso, setSelectedIdoso] = useState<any | null>(null); // Estado para o idoso selecionado
    const router = useRouter();

    const [vacinaData, setVacinaData] = useState({
        nome: '',
        marca: '',
        descricao: '',
        validade: ''
    });

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        const { name, value } = e.target;
        setVacinaData({ ...vacinaData, [name]: value });
    };

    const handleSubmit = async (e: SyntheticEvent) => {
        e.preventDefault();
        setLoading(true);
        setError("");
        setMessage("");
        try {
            const response = await axios.post("http://127.0.0.1:8000/api/createvacina", vacinaData);
            if (response.data.success) {
                setMessage("Vacina cadastrada com sucesso!");
            } else {
                setError("Erro ao cadastrar vacina");
            }
            setShowForm(false);
        } catch (error) {
            setError("Erro ao cadastrar vacina");
        } finally {
            setLoading(false);
        }
    };

    const handleListIdosos = async () => {
        setLoading(true);
        setError("");
        setMessage("");
        try {
            const response = await axios.get("http://127.0.0.1:8000/api/listidosos");
            if (response.data && Array.isArray(response.data.idosos)) {
                setIdosos(response.data.idosos);
                setShowIdosos(true);
            } else {
                setError("Erro ao buscar lista de idosos");
            }
        } catch (error) {
            setError("Erro ao buscar lista de idosos");
        } finally {
            setLoading(false);
        }
    };

    const handleListVacinas = () => {
        router.push('/listar-vacinas');
    };

    const toggleForm = () => {
        setShowForm(!showForm);
    };

    const handleIdosoClick = (idoso: any) => {
        setSelectedIdoso(idoso);
    };

    const handleCloseModal = () => {
        setSelectedIdoso(null);
    };

    return (
        <div className="container">
            <h1 className="title">Cadastro de Vacinas</h1>
            <div className="button-group">
                <button className="button" onClick={handleListIdosos}>Pessoas a serem Cuidadas</button>
                <button className="button" onClick={handleListVacinas}>Listar Vacinas</button>
                <button className="button" onClick={toggleForm}>
                    {showForm ? 'Fechar Formulário' : 'Cadastrar Vacina'}
                </button>
            </div>
            
            {loading && <Loading />}
            {error && <Toast message={error} type="error" />}
            {message && <Toast message={message} type="success" />}

            {showForm && (
                <form onSubmit={handleSubmit}>
                    <div className="form-group">
                        <label className="label" htmlFor="nome">Nome</label>
                        <input
                            className="input"
                            type="text"
                            id="nome"
                            name="nome"
                            value={vacinaData.nome}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label className="label" htmlFor="marca">Marca</label>
                        <input
                            className="input"
                            type="text"
                            id="marca"
                            name="marca"
                            value={vacinaData.marca}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label className="label" htmlFor="descricao">Descrição</label>
                        <textarea
                            className="input"
                            id="descricao"
                            name="descricao"
                            value={vacinaData.descricao}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <div className="form-group">
                        <label className="label" htmlFor="validade">Validade</label>
                        <input
                            className="input"
                            type="date"
                            id="validade"
                            name="validade"
                            value={vacinaData.validade}
                            onChange={handleChange}
                            required
                        />
                    </div>
                    <button className="button" type="submit">Cadastrar</button>
                </form>
            )}

            {showIdosos && (
                <div className="idosos-list">
                    <h2>Lista de Idosos</h2>
                    {idosos.length > 0 ? (
                        <ul>
                            {idosos.map((idoso) => (
                                <li key={idoso.id} onClick={() => handleIdosoClick(idoso)}>
                                    <p>Nome: {idoso.nome}</p>
                                    <p>Data de Nascimento: {idoso.data_nascimento}</p>
                                    <p>Telefone: {idoso.telefone}</p>
                                    <p>Endereço: {idoso.endereco}, {idoso.numero}, {idoso.cidade}, {idoso.cep}</p>
                                    <p>Comorbidade: {idoso.comorbidade}</p>
                                </li>
                            ))}
                        </ul>
                    ) : (
                        <p>Nenhum idoso encontrado.</p>
                    )}
                </div>
            )}

            <AgendamentoModal isOpen={selectedIdoso !== null} onClose={handleCloseModal} idoso={selectedIdoso} />
        </div>
    );
};

export default Agentes;
