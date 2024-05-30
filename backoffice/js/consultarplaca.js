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
    let placa = await fetchSingleData(textboxConsultarPlaca);
    console.log(placa);

});

async function fetchSingleData(placa) {
    const response = await fetch(`http://localhost:8089/ciudadanos/${placa}`);
    return response.json();
}