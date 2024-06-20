import axios from "axios";
import { NextResponse } from "next/server";
import jwt from "jsonwebtoken";

export async function POST(req: Request) {
    const { cpf, password } = await req.json();

    console.log(cpf);
    try {
        let usuario = await axios.get(
            `http://127.0.0.1:8000/api/login?cpf=${cpf}&password=${password}`
        );
        console.log(usuario);
        if (usuario.data.length === 1) {
            if (usuario.data[0].password === password) {
                let objusuario = usuario.data[0];

                delete objusuario.password;

                const token = jwt.sign(
                    objusuario,
                     "123456",//secret
                      {
                         expiresIn: "1d",
                         // expiresIn: "1h", horas
                        // expiresIn: "1min", minutos
                      }
                );
                return NextResponse.json({token: token})
            }
        }
        return NextResponse.json(
            {
                message: "Dados incorretos",
            },
            { status: 401 }
        );
    } catch (err) {
        console.log(err);
        return NextResponse.json(
            {
                message: "Erro interno",
            },
            {
                status: 500,
            }
        );
    }
}
