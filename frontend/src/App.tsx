import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/index1';
import Login from '@/app/login/page';
import Cadastro from './pages/cadastro';
import Sobre from './pages/Sobre';
import Servicos from './pages/Servico';
import '../styles/global.css';

const App: React.FC = () => {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/login" element={<Login />} />
        <Route path="/cadastro" element={<Cadastro />} />
        <Route path="/sobre" element={<Sobre />} />
        <Route path="/servicos" element={<Servicos />} />
        {/* Outras rotas serão adicionadas aqui conforme necessário */}
      </Routes>
    </Router>
  );
};

export default App;
