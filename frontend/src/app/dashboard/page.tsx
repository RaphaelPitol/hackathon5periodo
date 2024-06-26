import { LayoutDashboard } from "@/app/componentes/LayoutDashboard";
import { verificaTokenExpirado } from "@/services/token";
import { cookies } from 'next/headers';
import { redirect } from "next/navigation";
import jwt from "jsonwebtoken";

interface DecodedToken {
    iss: string;
    sub: {
        id: number;
        nome: string;
        telefone: string;
        cpf: string;
        password: string;
        created_at: string;
        updated_at: string;
    };
    iat: number;
    exp: number;
}

export default function Dashboard() {
    const cookie = cookies();
    const token = cookie.get('hackathon.token');

    if (!token?.value || verificaTokenExpirado(token.value)) {
        redirect('./pages/index');
    }

    let id = '';

    if (token?.value) {
        try {
            const decodedToken = jwt.decode(token.value) as unknown as DecodedToken;
            id = decodedToken?.sub?.id.toString() || '';
        } catch (error) {
            console.error("Token decoding failed:", error);
            redirect('./pages/index');
        }
    }

    return (
        <LayoutDashboard token={token.value}>
            <h1>ID: {id}</h1> 
        </LayoutDashboard>
    );
}
