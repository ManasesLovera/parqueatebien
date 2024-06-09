// Ejemplo de datos de usuarios
const users = [
    { codigo: '001', nombre: 'Usuario 1', tipo: 'Admin', estatus: 'Activo' },
    { codigo: '002', nombre: 'Usuario 2', tipo: 'Usuario', estatus: 'Inactivo' },
    { codigo: '003', nombre: 'Usuario 3', tipo: 'Usuario', estatus: 'Activo' }
];

// Datos del usuario que ha iniciado sesión (ejemplo)
const currentUser = {
    nombre: 'Nombre de Usuario',
    correo: 'correo@example.com',
    imagen: '../src/img/user.jpg'
};

// Función para mostrar los usuarios en la tabla
function displayUsers(filteredUsers) {
    const userList = document.querySelector('#user-list');
    userList.innerHTML = ''; // Limpia el contenido existente

    filteredUsers.forEach(user => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td>${user.codigo}</td>
            <td>${user.nombre}</td>
            <td>${user.tipo}</td>
            <td>${user.estatus}</td>
            <td class="actions">
                <button class="edit-button" onclick="openEditarUsuarioPopup('${user.codigo}')">Editar</button>
                <button class="delete-button" onclick="openEliminarUsuarioPopup('${user.codigo}')">Eliminar</button>
            </td>
        `;

        userList.appendChild(row);
    });
}
// Función para filtrar usuarios
function filterUsers(event) {
    event.preventDefault();

    const name = document.querySelector('#nombre').value.toLowerCase();
    const code = document.querySelector('#codigo').value.toLowerCase();
    const status = document.querySelector('#estatus').value.toLowerCase();

    const filteredUsers = users.filter(user => {
        return (
            (name === '' || user.nombre.toLowerCase().includes(name)) &&
            (code === '' || user.codigo.toLowerCase().includes(code)) &&
            (status === '' || user.estatus.toLowerCase() === status)
        );
    });

    displayUsers(filteredUsers);
}

// Función para eliminar un usuario
function eliminarUsuario(codigo) {
    // Realizar una solicitud DELETE al servidor para eliminar el usuario con el código especificado
    fetch(`URL_DEL_SERVIDOR/usuarios/${codigo}`, {
        method: 'DELETE'
    })
    .then(response => {
        if (response.ok) {
            // Usuario eliminado correctamente
            console.log(`Usuario con código ${codigo} eliminado`);
            // Aquí podrías realizar alguna acción adicional, como actualizar la lista de usuarios
        } else {
            // Error al eliminar usuario
            console.error('Error al eliminar usuario:', response.statusText);
        }
        // Cerrar el popup de eliminar usuario
        closePopup('eliminarUsuarioPopup');
    })
    .catch(error => {
        console.error('Error al procesar la solicitud:', error);
        // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
    });
}

// Función para editar un usuario
function editarUsuario(codigo) {
    // Aquí puedes obtener los nuevos valores del usuario desde el formulario de edición

    // Por ejemplo, supongamos que tienes un objeto con los nuevos datos del usuario
    const nuevosDatosUsuario = {
        nombre: 'Nuevo nombre',
        apellido: 'Nuevo apellido',
        // Otros campos actualizados...
    };

    // Realizar una solicitud PUT al servidor para actualizar los datos del usuario
    fetch(`URL_DEL_SERVIDOR/usuarios/${codigo}`, {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(nuevosDatosUsuario)
    })
    .then(response => {
        if (response.ok) {
            // Usuario actualizado correctamente
            console.log(`Usuario con código ${codigo} actualizado`);
            // Aquí podrías realizar alguna acción adicional, como actualizar la lista de usuarios
        } else {
            // Error al actualizar usuario
            console.error('Error al actualizar usuario:', response.statusText);
        }
        // Cerrar el popup de editar usuario
        closePopup('editarUsuarioPopup');
    })
    .catch(error => {
        console.error('Error al procesar la solicitud:', error);
        // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
    });
}

// Inicializar datos del usuario actual
function initializeCurrentUser() {
    document.querySelector('#user-name').textContent = currentUser.nombre;
    document.querySelector('#user-email').textContent = currentUser.correo;
    document.querySelector('#user-image').src = currentUser.imagen;
}

document.addEventListener('DOMContentLoaded', () => {
    displayUsers(users);
    initializeCurrentUser();
    document.querySelector('.search-btn').addEventListener('click', filterUsers);
});
// Function to open a popup
function openPopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "block";
}

// Function to close a popup
function closePopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "none";
}

// Close popup when clicking outside of it
window.onclick = function(event) {
    const popups = document.querySelectorAll('.popup');
    for (let i = 0; i < popups.length; i++) {
        const popup = popups[i];
        if (event.target == popup) {
            popup.style.display = "none";
        }
    }
}
const agregarUsuarioButton = document.getElementById('agregarUsuarioButton');

// Obtener referencia al popup "Crear usuario"
const crearUsuarioPopup = document.getElementById('crearUsuarioPopup');

// Agregar evento de clic al botón "Crear nuevo usuario"
agregarUsuarioButton.addEventListener('click', function() {
    // Mostrar el popup "Crear usuario"
    openPopup('crearUsuarioPopup');
});