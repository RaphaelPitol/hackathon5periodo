import axios from "axios";
import { NextResponse } from "next/server";
import jwt from "jsonwebtoken";

export async function POST(req: Request) {
    const { email, senha } = await req.json();

    try {
        let usuario = await axios.get(
            "http://localhost:3001/usuarios?email=" + email
        );
        console.log(usuario);
        if (usuario.data.length === 1) {
            if (usuario.data[0].senha === senha) {
                let objusuario = usuario.data[0];

                delete objusuario.senha;

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
