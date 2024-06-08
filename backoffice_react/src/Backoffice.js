import imgReport from './img/REPORT.svg'
import imgFlecha from './img/pngwing.com.png'
import './backoffice.css'
import {Nav} from './nav.js'
import React from 'react';
import {useLocation, useNavigate} from 'react-router-dom';
import { useState, useEffect } from 'react';

export default function Backoffice() {

    const navigate = useNavigate();
    const location = useLocation();

    let url = 'https://parqueatebiendemo.azurewebsites.net';

    const [licensePlate, setLicensePlate] = useState('');
    const [reportado, setReportado] = useState('');
    const [incautado, setIncautado] = useState('');
    const [retenido, setRetenido] = useState('');
    const [error, setError] = useState(null);
    const username = location?.state?.username;

    useEffect(() => {

        let isMounted = true;

        const fetchData = async () => {
            try {
                let response = await fetch(`${url}/ciudadanos/estadisticas`);
                if(response.ok) {
                    let data = await response.json();
                    if(isMounted) {
                        setReportado(data.filter(status => status === 'Reportado').length);
                        setIncautado(data.filter(status => status === 'Incautado por grua').length);
                        setRetenido(data.filter(status => status === 'Retenido').length);
                    }
                } else {
                    alert('Error fetching data: ', response.statusText);
                }
            }
            catch (err) {
                alert('Error fetching data: ', error);
            }
        }
        fetchData();

        return () => {
            isMounted = false;
        }
        
    }, [url])

    async function handleConsultarButton() {
        if (licensePlate.trim() == '') {
            alert('Ingresa digitos de la placa');
            return;
        }
        try{
            const response = await fetch(`${url}/ciudadanos/${licensePlate}`);
            if(response.ok) {
                navigate('/resultado', {
                    state: {
                        username: username,
                        licensePlate: licensePlate.trim()
                    }
                })
                setError(null);
            }
            else if(response.status == 404){
                alert('La placa no existe');
                return;
            }
            else if(response.status == 500){
                alert("SERVER ERROR");
                return;
            }
            else if(response.status == 400){
                alert("Bad Request");
                return;
            }
        }
        catch (err) {
            alert('Error fetching data: ', err)
        }
    }

    if(location?.state?.username == null) {
        navigate('/login');
        return;
    }

    return (
        <div>
            <Nav username={username} />
            <main id="main">
                <article className="consultar_placa">
                    <h1>Consultar placa</h1>
                    <section className="busqueda">
                        <input type="text" 
                        placeholder="Ingresar digitos de placa" 
                        value={licensePlate} 
                        onChange={(e) => setLicensePlate(e.target.value)} />
                        <button 
                        className="btn-consultarplaca" 
                        onClick={handleConsultarButton}>Buscar</button>
                    </section>
                </article>
                <article>
                    <section className="ver-reportes">
                        <div className="ver-reportes-grafico">
                            <img src={imgReport} alt="Back" />
                        </div>
                        <div className="ver-reportes-texto">
                            <h4>Ver reportes</h4>
                            <p>Visualiza todos los vehículos reportados e incautados</p>
                        </div>
                        <div className="ver-reportes-flecha">
                            <img src={imgFlecha} alt="flecha" />
                        </div>
                    </section>
                    
                    <section className="estadisticas">
                        <h2>{`ESTADÍSTICAS AL DÍA ${new Date(Date.now()).toLocaleDateString()}`}</h2>
                        <section className="reportes">
                            <ReporteVehiculos value={reportado} status='reportados' message='Vehículos reportados' />
                            <ReporteVehiculos value={incautado} status='recogidos' message='Vehículos recogidos por Grúa' />
                            <ReporteVehiculos value={retenido} status='retenidos' message='Vehículos en centros de retención' />
                        </section>
                    </section>
                </article>
            </main>
        </div>
    )
    function ReporteVehiculos(props) {
        return (
            <span className="vehiculos">
                <p className="cantidad-vehiculos" id={props.status}>{props.value}</p>
                <p className="descripcion-vehiculos">{props.message}</p>
            </span>
        )
    }
}