import React, { useState, useLayoutEffect } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import imgBusqueda from './img/BUSQUEDA.svg'
import { Nav } from './nav'
import './resultadoconsulta.css'

export function ResultadoConsulta() {

    const url = "https://parqueatebiendemo.azurewebsites.net"
    
    const [report, setReport] = useState({});
    const [images, setImages] = useState([]);

    const navigate = useNavigate();
    const location = useLocation();

    const licensePlate = location?.state?.licensePlate;
    const username = location?.state?.username;

    useLayoutEffect(() => {

        const fetchData = async () => {

            const response = await fetch(`${url}/ciudadanos/${licensePlate}`);
            if(response.ok) {
                const data = await response.json();
                console.log(data);
                setReport(data);
                setImages(data.Photos);
            }
            else {
                navigate('/resultadoError', {state: {username: username}});
            }
            
        }
        fetchData()
    }, [url,licensePlate,navigate,images,username])

    if(licensePlate === null || licensePlate === undefined) {
        navigate('/backoffice', {
            state: {
                username: username
            }
        });
        return;
    }

    const statusClassName = report.Status === 'Reportado' ? 'reportado' :
                            report.Status === 'Incautado por grua' ? 'incautado' :
                            report.Status === 'Retenido' ? 'retenido' :
                            report.Status === 'Liberado' ? 'liberado' : '';

    async function handleSetStatusButton(e) {
        e.preventDefault();
        let newStatus = '';
        if(report.Status === 'Incautado por grua') 
            newStatus = 'Retenido';
        
        else if(report.Status === 'Retenido') 
            newStatus = 'Liberado';
        
        else 
            return;

        await fetch(`${url}/ciudadanos/updateStatus`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({licensePlate: licensePlate, newStatus: newStatus, username: username})
        })
        navigate('/resultado', {
            state: {
                username: username,
                licensePlate: licensePlate.trim()
            }
        })
    }

    return (
        <>
        <Nav username={username}/>
        <article className="title">
            <h1>RESULTADO DE CONSULTA</h1>
        
            <button onClick = {()=>{navigate('/backoffice', {state: {username: username}})}} id="btnRealizarOtraConsulta">
                <img src={imgBusqueda} alt="Logo busqueda" />
                Realizar otra consulta</button>
        </article>

        <div className="resultado-consulta">

            <section className="datos">
                <article className="datos-vehiculo">
                    <h3>Datos del vehículo</h3>
                    <div className="dato">
                        <div>
                            <h4 className="subtitleh4">No. de Registro:</h4>
                            <p id="placa">{`PB20240610`+licensePlate[1]}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Placa:</h4>
                            <p id="placa">{report.LicensePlate}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Tipo de vehiculo:</h4>
                            <p>{report.VehicleType}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Color:</h4>
                            <p>{report.VehicleColor}</p>
                        </div>
                    </div>
                    
                </article>
                <article className="reporte-creado-por">
                    <h3>Reporte creado por</h3>
                    <div className="dato">
                        <div>
                            <h4 className="subtitleh4">Nombre del agente:</h4>
                            <p>{report.ReportedBy}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Fecha y hora del reporte:</h4>
                            <p>{report.ReportedDate}</p>
                        </div>
                    </div>
                    
                </article>
                <div id="setStatus">
                    
                    <article className={`setStatus ${(report.Status === 'Incautado por grua' || report.Status === 'Retenido') ? '' : 'hidden'}`}>
                        <p>{report.Status === 'Incautado por grua' ? 'Si el vehículo ha sido recibido en el centro de retención favor confirmar.' : 
                            report.Status === 'Retenido' ? `Multa pagada. Vehículo apto para liberación.` : ''}</p>
                        <button onClick={handleSetStatusButton}>{report.Status === 'Incautado por grua' ? 'Vehículo recibido' : 
                            report.Status === 'Retenido' ? 'Liberar vehículo' : ''}</button>
                    </article>   
                    
                </div>
                <article className="fotos-vehiculo">
                    <h3>Fotos del vehículo</h3>
                    <div id="imagenes" className="imagenes">
                        {
                            images.map( (photo,index) => 
                                <img key={index} src={`${photo.FileType}${photo.File}`} alt={`${index}`} />
                            )
                        }
                    </div>
                </article>
            </section>
            <section className="informacion">
                <h3 className="subtitleh3">Información del reporte</h3>
                <h5>Estatus</h5>
                <span id="status" className={`status ${statusClassName}`}>{report.Status}</span>
                <h5>Ubicación de reporte / recogida:</h5>
                <span>{report.Address}</span>
                <h5>Fecha y hora de incautación por grúa:</h5>
                <span>{report.TowedByCraneDate || 'N/A'}</span>
                <h5>Ubicación actual:</h5>
                <span>{report.CurrentAddress}</span>
                <h5>Fecha y hora de llegada al centro:</h5>
                <span>{report.ArrivalAtParkinglot || 'N/A'}</span>
                <h5>Fecha y hora de liberación:</h5>
                <span>{report.ReleaseDate || 'N/A'}</span>
                <h5>Liberado por:</h5>
                <span>{report.ReleasedBy || 'N/A'}</span>
            </section>
        </div>
    </>
    )
}