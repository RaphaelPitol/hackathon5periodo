import { LayoutDashboard } from "@/componentes/LayoutDashboard";
import { verificaTokenExpirado } from "@/services/token";
import {cookies} from 'next/headers'
import { redirect } from "next/navigation";

export default function Dashboard(){

    const cookie = cookies();

    const token = cookie.get('painel1pitchau.token')


    if (!token?.value || verificaTokenExpirado(token.value)) {
        redirect('/login')
    }

    return(
        <LayoutDashboard
        token = {token.value}
        >
          <h1>Teste</h1> 
        </LayoutDashboard>
    )
}