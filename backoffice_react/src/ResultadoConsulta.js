import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import imgBusqueda from './img/BUSQUEDA.svg'

export async function ResultadoConsulta(props) {

    const url = "https://demooriontek.azurewebsites.net"
    const licensePlate = props.licensePlate;
    const data = await (await fetch(`${url}/ciudadanos/${licensePlate}`)).json();

    const navigate = useNavigate();
    
    let towedByCraneDate = 'N/A';
    let currentAddress = 'N/A';
    let arrivalAtParkinglot = 'N/A';
    let releaseDate = 'N/A';

    



        towedByCraneDate = data.TowedByCraneDate && data.TowedByCraneDate;
        currentAddress = data.CurrentAddress === '' ? 'N/A' : data.CurrentAddress;
        arrivalAtParkinglot = data.ArrivalAtParkinglot === '' ? 'N/A' : data.ArrivalAtParkinglot;
        releaseDate = data.ReleaseDate === '' ? 'N/A' : data.ReleaseDate;

        const reportados = document.getElementById('reportados');
        const recogidos = document.getElementById('recogidos');
        const retenidos = document.getElementById('retenidos');
        let estadistica = await (await fetch(`${url}/ciudadanos/estadisticas`)).json();

        reportados.innerHTML = estadistica.filter(status => status === 'Reportado').length;
        recogidos.innerHTML = estadistica.filter(status => status === 'Incautado por grua').length;
        retenidos.innerHTML = estadistica.filter(status => status === 'Retenido').length;

    

    return (
        <>
        <article className="title">
            <h1>RESULTADO DE CONSULTA</h1>
        
            <button onClick = {()=>{navigate('/backoffice')}} id="btnRealizarOtraConsulta">
                <img src={imgBusqueda} />
                Realizar otra consulta</button>
        </article>

        <div classNameName="resultado-consulta">

            <section className="datos">
                <article className="datos-vehiculo">
                    <h3>Datos del vehículo</h3>
                    <div className="dato">
                        <div>
                            <h4 className="subtitleh4">No. de Registro y placa:</h4>
                            <p id="placa">{data.LicensePlate}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Tipo de vehiculo:</h4>
                            <p>{data.VehicleType}</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Color:</h4>
                            <p>{data.VehicleColor}</p>
                        </div>
                    </div>
                    
                </article>
                <article className="reporte-creado-por">
                    <h3>Reporte creado por</h3>
                    <div className="dato">
                        <div>
                            <h4 className="subtitleh4">Nombre del agente:</h4>
                            <p>Juan Manuel Sanchez Ruiz</p>
                        </div>
                        <div>
                            <h4 className="subtitleh4">Fecha y hora del reporte:</h4>
                            <p>{data.ReportedDate}</p>
                        </div>
                    </div>
                    
                </article>
                <div id="setStatus">
                </div>
                <article className="fotos-vehiculo">
                    <h3>Fotos del vehículo</h3>
                    <div id="imagenes" className="imagenes">

                    </div>
                </article>
            </section>
            <section className="informacion">
                <h3 className="subtitleh3">Información del reporte</h3>
                <h5>Estatus</h5>
                <span id="status" className="status">{data.Status}</span>
                <h5>Ubicación de reporte / recogida:</h5>
                <span>{data.Address}</span>
                <h5>Fecha y hora de incautación por grúa:</h5>
                <span>{towedByCraneDate}</span>
                <h5>Ubicación actual:</h5>
                <span>{currentAddress}</span>
                <h5>Fecha y hora de llegada al centro:</h5>
                <span>{arrivalAtParkinglot}</span>
                <h5>Fecha y hora de liberación:</h5>
                <span>{releaseDate}</span>
                <h5>Liberado por:</h5>
                <span>N/A</span>
            </section>
        </div>
    </>
    )
    
}

function ResultNotOk(props) {
    const navigate = useNavigate();
    return (
        <>
            <h1>{props.status}</h1>
            <button onClick={()=> navigate('/backoffice')}>Volver Atras</button>
        </>
    )
}

async function retrieveData(licensePlate) {
    let response = await fetch(`https://demooriontek.azurewebsites.net/ciudadanos/${licensePlate}`);
    if(!response.ok)
        return response.status;
    let body = await response.json();
    return body;
}
