"use client"

import { useState } from "react"

export default function Categoria({params}: {params: {id: string}}){
     const[teste, setTeste] = useState("Teste")

     return(
          <>
          <h1>Parametros:{params.id}</h1>
          <h1>state:{teste}</h1>
          </>
     )
}