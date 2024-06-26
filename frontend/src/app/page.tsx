import React from 'react';
import Layout from '../components/Layout';
import '../styles/global.css';

const Home: React.FC = () => {
    return (
        <Layout>
            <h1>Bem vindo ao Hackathon</h1>
            <p>Agradeçemos a presença de todos!</p>
            <div className="health-links-container">
                <div className="health-link-card">
                    <a href="https://www.saude.gov.br/" target="_blank" rel="noopener noreferrer">
                        Ministério da Saúde
                    </a>
                </div>
                <div className="health-link-card">
                    <a href="https://www.umuarama.pr.gov.br/boletim-saude/" target="_blank" rel="noopener noreferrer">
                        Umuarama poletim da saúde
                    </a>
                </div>
                <div className="health-link-card">
                    <a href="https://www.uopeccan.org.br/" target="_blank" rel="noopener noreferrer">
                        Hopital Uopeccan
                    </a>
                </div>
                <div className="health-link-card">
                    <a href="https://portal.fiocruz.br/" target="_blank" rel="noopener noreferrer">
                        Fiocruz
                    </a>
                </div>
                <div className="health-link-card">
                    <a href="https://www.hcor.com.br/" target="_blank" rel="noopener noreferrer">
                        HCor - Hospital do Coração
                    </a>
                </div>
                <div className="health-link-card">
                    <a href="https://www.hospitalsiriolibanes.org.br/" target="_blank" rel="noopener noreferrer">
                        Hospital Sírio-Libanês
                    </a>
                </div>
            </div>
        </Layout>
    );
};

export default Home;
