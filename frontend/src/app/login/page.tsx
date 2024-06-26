"use client";
import { SyntheticEvent, useCallback, useRef, useState, useEffect } from "react";
import styles from "./style.module.css";
import axios from "axios";
import { Toast } from "@/app/componentes/Toast";
import { Loading } from "@/app/componentes/Loading";
import { useRouter } from "next/navigation";
import { setCookie, parseCookies } from 'nookies';
import jwt from "jsonwebtoken";

export default function Login() {

    const router = useRouter();

    const refForm = useRef<any>();
    const [toast, setToast] = useState(false);
    const [loading, setLoading] = useState(false);
    const [userType, setUserType] = useState("agente"); // Default to "agente"
    const [responsavelId, setResponsavelId] = useState<string | null>(null);

    useEffect(() => {
        const cookies = parseCookies();
        const token = cookies['hackathon.token'];
        
        if (token) {
            try {
                const decodedToken = jwt.decode(token) as any;
                setResponsavelId(decodedToken?.sub?.id || null);
            } catch (error) {
                console.error("Token decoding failed:", error);
            }
        }
    }, []);

    const submitForm = useCallback((e: SyntheticEvent) => {
        e.preventDefault();

        if (refForm.current.checkValidity()) {
            setLoading(true);

            const target = e.target as typeof e.target & {
                cpf: { value: string };
                password: { value: string };
            };

            const endpoint = userType === "agente"
                ? "http://127.0.0.1:8000/api/loginagente"
                : "http://127.0.0.1:8000/api/login";

            axios
                .post(endpoint, {
                    cpf: target.cpf.value,
                    password: target.password.value,
                })
                .then((res) => {
                    console.log(res.data);
                    
                    setCookie(
                        undefined,
                        'hackathon.token',
                        res.data.token,
                        { path: '/' }
                    );

                    const redirectPage = userType === "agente" ? "/agentes" : "/responsavel";
                    router.push(redirectPage);
                    setLoading(false);
                })
                .catch((err) => {
                    console.log(err);
                    setLoading(false);
                    setToast(true);
                });
        } else {
            refForm.current.classList.add("was-validated");
        }
    }, [userType]);

    return (
        <>
            <Loading loading={loading} />
            <Toast
                show={toast}
                message="Dados Inválidos"
                colors="danger"
                onClose={() => {
                    setToast(false);
                }}
            />
            <div className={styles.main}>
                <div className={styles.border}>
                    <div className="d-flex flex-column align-items-center">
                        <img className='mb-4' src='https://www.alfaumuarama.edu.br/fau/images/logo_novo.png?v=1715725731' />
                        <h1 className="text-primary">Login</h1>
                        <p className="text-secondary text2">
                            Preencha os campos para logar no sistema!
                        </p>
                    </div>
                    <hr />
                    <form
                        action=""
                        className="needs-validation align-items-center"
                        noValidate
                        onSubmit={submitForm}
                        ref={refForm}
                    >
                        <div className="col-md-12 mt-1">
                            <label htmlFor="userType" className="from-label">
                                Tipo de Usuário
                            </label>
                            <select
                                id="userType"
                                className="form-control"
                                value={userType}
                                onChange={(e) => setUserType(e.target.value)}
                                required
                            >
                                <option value="agente">Agente</option>
                                <option value="responsavel">Responsável</option>
                            </select>
                            <div className="invalid-feedback">
                                Por favor selecione o tipo de usuário
                            </div>
                        </div>
                        <div className="col-md-12 mt-1">
                            <label htmlFor="cpf" className="from-label">
                                CPF
                            </label>
                            <input
                                type="text"
                                className="form-control"
                                placeholder="Digite seu CPF"
                                id="cpf"
                                required
                            />
                            <div className="invalid-feedback">
                                Por favor digite seu CPF
                            </div>
                        </div>
                        <div className="col-md-12">
                            <label htmlFor="password" className="from-label">
                                Senha
                            </label>
                            <input
                                type="password"
                                className="form-control"
                                placeholder="Digite sua senha"
                                id="password"
                                required
                            />
                            <div className="invalid-feedback">
                                Por favor digite sua senha
                            </div>
                        </div>
                        <div className="col-md-12 mt-3">
                            <button
                                className="btn btn-primary w-100"
                                type="submit"
                                id="botao"
                            >
                                Enviar
                            </button>
                        </div>
                    </form>
                    {responsavelId && <p>ID do Responsável: {responsavelId}</p>}
                </div>
            </div>
            <p className='text-center m-4'>© 2024 Unialfa Umuarama  |  Todos os direitos reservados</p>
        </>
    );
}
