"use client";
import { SyntheticEvent, useCallback, useRef, useState } from "react";
import styles from "./style.module.css";
import axios from "axios";
import { Toast } from "@/componentes/Toast";
import { Loading } from "@/componentes/Loading";
import { useRouter } from "next/navigation";
import {setCookie} from 'nookies'
import  jwt  from "jsonwebtoken";
import { NextResponse } from "next/server";

export default function Login() {

    const router = useRouter()

    const refForm = useRef<any>();
    const [toast, setToast] = useState(false);
    const [loading, setLoading] = useState(false);

    const submitForm = useCallback((e: SyntheticEvent) => {
        e.preventDefault();

        if (refForm.current.checkValidity()) {
            setLoading(true);

            const target = e.target as typeof e.target & {
                cpf: { value: string };
                password: { value: string };
            };

            axios
                .post("http://127.0.0.1:8000/api/loginagente", {
                    cpf: target.cpf.value,
                    password: target.password.value,
                })
                .then((res) => {
                    console.log(res.data)
                    console.log("teste")
                    
                    setCookie(
                        undefined,
                        'painel1pitchau.token',
                         res.data.token
                    )

                    router.push('/dashboard')
                    setLoading(false)
                })
                .catch((err) => {
                    console.log(err);
                    setLoading(false)
                    setToast(true);
                });
        } else {
            refForm.current.classList.add("was-validated");
        }
    }, []);

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
                    <img className='mb-4'src='https://www.alfaumuarama.edu.br/fau/images/logo_novo.png?v=1715725731'/>
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
                            <label htmlFor="cpf" className="from-label">
                                E-mail
                            </label>
                            <input
                                type="cpf"
                                className="form-control"
                                placeholder="Digite seu email"
                                id="cpf"
                                required
                            />
                            <div className="invalid-feedback">
                                Por favor digite seu email
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
                </div>
            </div>
            <p className='text-center m-4'>© 2024 Unialfa Umuarama  |  Todos os direitos reservados</p>
        </>
    );
}
