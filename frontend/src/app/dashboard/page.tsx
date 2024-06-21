import { LayoutDashboard } from "@/componentes/LayoutDashboard";
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
    const token = cookie.get('painel1pitchau.token');

    if (!token?.value || verificaTokenExpirado(token.value)) {
        redirect('/login');
    }

    let nome = '';

    if (token?.value) {
        try {
            const decodedToken = jwt.decode(token.value) as unknown as DecodedToken;
            nome = decodedToken?.sub?.nome || '';
        } catch (error) {
            console.error("Token decoding failed:", error);
            redirect('/login');
        }
    }

    return (
        <LayoutDashboard token={token.value}>
            <h1>Nome: {nome}</h1> 
        </LayoutDashboard>
    );
}
