import React from 'react';
import '../styles/VaccineSchedule.css';

const VaccineSchedule: React.FC = () => {
  const vaccines = [
    {
      age: 'A partir de 20 anos',
      vaccine: 'dT (Dupla tipo adulto)(1)',
      dose: '1ª dose',
      diseases: 'Contra Difteria e Tétano'
    },
    {
      age: 'A partir de 20 anos',
      vaccine: 'Febre amarela (2)',
      dose: 'dose inicial',
      diseases: 'Contra Febre Amarela'
    },
    {
      age: 'A partir de 20 anos',
      vaccine: 'SCR (Tríplice viral)(3)',
      dose: 'dose única',
      diseases: 'Contra Sarampo, Caxumba e Rubéola'
    },
    {
      age: '2 meses após a 1ª dose contra Difteria e Tétano',
      vaccine: 'dT (Dupla tipo adulto)',
      dose: '2ª dose',
      diseases: 'Contra Difteria e Tétano'
    },
    {
      age: '4 meses após a 1ª dose contra Difteria e Tétano',
      vaccine: 'dT (Dupla tipo adulto)',
      dose: '3ª dose',
      diseases: 'Contra Difteria e Tétano'
    },
    {
      age: 'a cada 10 anos, por toda a vida',
      vaccine: 'dT (Dupla tipo adulto)(4)',
      dose: 'reforço',
      diseases: 'Contra Difteria e Tétano'
    },
    {
      age: 'a cada 10 anos, por toda a vida',
      vaccine: 'Febre amarela',
      dose: 'reforço',
      diseases: 'Contra Febre Amarela'
    },
    {
      age: '60 anos ou mais',
      vaccine: 'Influenza (5)',
      dose: 'dose anual',
      diseases: 'Contra Influenza ou Gripe'
    },
    {
      age: '60 anos ou mais',
      vaccine: 'Pneumococo (6)',
      dose: 'dose única',
      diseases: 'Contra Pneumonia causada pelo pneumococo'
    }
  ];

  return (
    <div className="vaccine-schedule">
      <h2>Quadro de Vacinas</h2>
      <table>
        <thead>
          <tr>
            <th>IDADE</th>
            <th>VACINAS</th>
            <th>DOSES</th>
            <th>DOENÇAS EVITADAS</th>
          </tr>
        </thead>
        <tbody>
          {vaccines.map((vaccine, index) => (
            <tr key={index}>
              <td>{vaccine.age}</td>
              <td>{vaccine.vaccine}</td>
              <td>{vaccine.dose}</td>
              <td>{vaccine.diseases}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default VaccineSchedule;
