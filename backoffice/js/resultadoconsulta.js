export async function displayResult(licensePlate) {
    const data = await retrieveData(licensePlate);
    let towedByCraneDate = data.TowedByCraneDate === '' ? 'N/A' : data.TowedByCraneDate;
    let currentAddress = data.CurrentAddress === '' ? 'N/A' : data.CurrentAddress;
    let arrivalAtParkinglot = data.ArrivalAtParkinglot === '' ? 'N/A' : data.ArrivalAtParkinglot;
    let releaseDate = data.ReleaseDate === '' ? 'N/A' : data.ReleaseDate;
    return `
    <article class="title">
    <h1>RESULTADO DE CONSULTA</h1>
    
        <button onclick = "()=>{window.location.href='../html/consultarplaca.html'}" id="btnRealizarOtraConsulta">
            
            <img src="../src/img/BUSQUEDA.svg">
            Realizar otra consulta</button>
    </article>

    <div class="resultado-consulta">

        <section class="datos">
            <article class="datos-vehiculo">
                <h3>Datos del vehículo</h3>
                <div class="dato">
                    <div>
                        <h4 class="subtitleh4">No. de Registro y placa:</h4>
                        <p>${data.LicensePlate}</p>
                    </div>
                    <div>
                        <h4 class="subtitleh4">Tipo de vehiculo:</h4>
                        <p>${data.VehicleType}</p>
                    </div>
                    <div>
                        <h4 class="subtitleh4">Color:</h4>
                        <p>${data.VehicleColor}</p>
                    </div>
                </div>
                
            </article>
            <article class="reporte-creado-por">
                <h3>Reporte creado por</h3>
                <div class="dato">
                    <div>
                        <h4 class="subtitleh4">Nombre del agente:</h4>
                        <p>Juan Manuel Sanchez Ruiz</p>
                    </div>
                    <div>
                        <h4 class="subtitleh4">Fecha y hora del reporte:</h4>
                        <p>${data.ReportedDate}</p>
                    </div>
                </div>
                
            </article>
            <article class="fotos-vehiculo">
                <h3>Fotos del vehículo</h3>
                <div id="imagenes" class="imagenes">

                </div>
            </article>
        </section>
        <section class="informacion">
            <h3 class="subtitleh3">Información del reporte</h3>
            <h5>Estatus</h5>
            <span id="status" class="status">${data.Status}</span>
            <h5>Ubicación de reporte / recogida:</h5>
            <span>${data.Address}</span>
            <h5>Fecha y hora de incautación por grúa:</h5>
            <span>${towedByCraneDate}</span>
            <h5>Ubicación actual:</h5>
            <span>${currentAddress}</span>
            <h5>Fecha y hora de llegada al centro:</h5>
            <span>${arrivalAtParkinglot}</span>
            <h5>Fecha y hora de liberación:</h5>
            <span>${releaseDate}</span>
            <h5>Liberado por:</h5>
            <span>N/A</span>
        </section>
    </div>
    `
    
}

export async function retrieveData(licensePlate) {
    let response = await fetch(`http://localhost:8089/ciudadanos/${licensePlate}`);
    let body = await response.json();
    console.log(body);
    return body;
}
