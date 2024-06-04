import {displayResult, retrieveData} from './resultadoconsulta.js'

document.addEventListener("DOMContentLoaded", () => {
    const h2 = document.getElementById('h2');
    let today = new Date(Date.now()).toLocaleDateString();
    h2.textContent = `ESTADÍSTICAS AL DÍA ${today}`;

    displayData();
});

async function displayData() {
    const reportados = document.getElementById('reportados');
    const recogidos = document.getElementById('recogidos');
    const retenidos = document.getElementById('retenidos');
    let data = await fetchData();

    reportados.innerHTML = data.filter(status => status === 'Reportado').length;
    recogidos.innerHTML = data.filter(status => status === 'Incautado por grua').length;
    retenidos.innerHTML = data.filter(status => status === 'Retenido').length;
}
async function fetchData() {
    let response = await fetch("http://localhost:8089/ciudadanos/estadisticas");
    let body = await response.json();
    return body;
}

const btnConsultarPlaca = document.getElementById('btn-consultarplaca');

btnConsultarPlaca.addEventListener('click', async () => {
    const textboxConsultarPlaca = document.getElementById('textbox-consultarplaca').value.trim();

    if (textboxConsultarPlaca == '') {
        alert('Ingresa digitos de la placa');
        return;
    }
    document.getElementById('root').innerHTML = await displayResult(textboxConsultarPlaca);

    const btnRealizarOtraConsulta = document.getElementById('btnRealizarOtraConsulta');

    btnRealizarOtraConsulta.addEventListener('click', () => {
        window.location.href = '../html/consultarplaca.html';
    });

    let status = document.getElementById('status');
    switch (status.innerHTML) {
        case 'Reportado': 
            status.classList.add('reportado');
            break;
        case 'Incautado por grua':
            status.classList.add('incautado');
            break;
        case 'Retenido':
            status.classList.add('retenido');
            break;
        case 'Liberado':
            status.classList.add('liberado');
            break;
    }

    let imgContainer = document.getElementById('imagenes');

    retrieveData(textboxConsultarPlaca)
    .then(data => {
        data.Photos.forEach( photo => {
            let img = document.createElement('img');
            let picture = photo.FileType + photo.File;
            img.src = picture;
            imgContainer.appendChild(img);
        })
    })
});