import {displayResult} from './resultadoconsulta.js'
document.addEventListener("DOMContentLoaded", () => {
    const h3 = document.getElementById('h3');
    let today = new Date(Date.now()).toLocaleDateString();
    h3.textContent = `ESTADÍSTICAS AL DÍA ${today}`;

    displayData();
});

async function displayData() {
    const reportados = document.getElementById('reportados');
    const recogidos = document.getElementById('recogidos');
    const retenidos = document.getElementById('retenidos');
    let data = await fetchData();

    reportados.innerHTML = data.filter(status => status === 'Reportado').length;
    recogidos.innerHTML = data.filter(status => status === 'Incautado por grúa').length;
    retenidos.innerHTML = data.filter(status => status === 'Retenido').length;
}
async function fetchData() {
    let response = await fetch("http://localhost:8089/ciudadanos/estadisticas");
    let body = await response.json();
    return body;
}

const btnConsultarPlaca = document.getElementById('btn-consultarplaca');

btnConsultarPlaca.addEventListener('click', async () => {
    const textboxConsultarPlaca = document.getElementById('textbox-consultarplaca').value;

    if (textboxConsultarPlaca.trim() == '') {
        alert('Ingresa digitos de la placa');
        return;
    }
    document.getElementById('root').innerHTML = await displayResult(textboxConsultarPlaca);

    let status = document.getElementById('status');
    switch (status.innerHTML.toLowerCase()) {
        case 'reportado': 
            status.classList.add('reportado');
            break;
        case 'incautado por grúa':
            status.classList.add('incautado');
            break;
        case 'retenido':
            status.classList.add('retenido');
            break;
        case 'liberado':
            status.classList.add('liberado');
            break;
    }

    const btnRealizarOtraConsulta = document.getElementById('btnRealizarOtraConsulta');

    btnRealizarOtraConsulta.addEventListener('click', () => {
        window.location.href = '../html/consultarplaca.html';
    });

});