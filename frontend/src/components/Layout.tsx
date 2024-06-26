import React, { ReactNode } from 'react';
import Link from 'next/link';
import '../styles/global.css';

interface LayoutProps {
    children: ReactNode;
}

const Layout: React.FC<LayoutProps> = ({ children }) => {
    return (
        <div>
            <header className="header">
                <nav>
                    <ul className="nav-list">
                        <li className="nav-item">
                            <Link href="/">Home</Link>
                        </li>
                        <li className="nav-item">
                            <Link href="/cadastro">Cadastro</Link>
                        </li>
                        <li className="nav-item">
                            <Link href="/sobre">Sobre</Link>
                        </li>
                        <li className="nav-item">
                            <Link href="/servicos">Serviços</Link>
                        </li>
                        <li className="nav-item">
                            <Link href="/login">Login</Link>
                        </li>
                    </ul>
                </nav>
            </header>
            <main className="main-content">
                {children}
            </main>
        </div>
    );
};

export default Layout;
