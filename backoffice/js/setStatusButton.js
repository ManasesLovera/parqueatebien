import {url} from './url.js';

export async function setStatusButton(placa, status) {
    alert(status)
    let newStatus;
    switch(status) {
        case 'Incautado por grua':
            newStatus = 'Retenido';
            break;
        case 'Retenido':
            newStatus = 'Liberado';
            break;
        default:
            return;
    }
    const result = await fetch(`${url}/ciudadanos/updateStatus`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({'licensePlate': placa,'newStatus': newStatus})
    })
    console.log(result);
    console.log(result.json());
}
