export function setStatus(status) {
    let p = document.createElement('p');
    let button = document.createElement('button');
    button.setAttribute('id', 'setStatusButton');
    let article = document.createElement('article');
    if(status.toLowerCase() == "incautado por grua") {
        p.innerHTML = `
            Si el vehículo ha sido recibido en el centro de retención favor confirmar.
        `
        button.innerHTML = `Vehículo recibido`
    }
    else if(status.toLowerCase() == "retenido") {
        p.innerHTML = `
            <span class="font-weight: bold;">Multa pagada.</span>
             Vehículo acepto para liberación.
        `
        button.innerHTML = `Liberar vehículo`;
    }
    else {
        return article;
    }
    article.classList.add('setStatus');
    article.appendChild(p);
    article.appendChild(button);
    return article;
}