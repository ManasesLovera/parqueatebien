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
    userList.innerHTML = '';

    filteredUsers.forEach(user => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td>${user.codigo}</td>
            <td>${user.nombre}</td>
            <td>${user.tipo}</td>
            <td>${user.estatus}</td>
            <td>
                <button class="delete-btn" onclick="eliminarUsuario('${user.codigo}')"></button>
                <button class="edit-btn" onclick="editarUsuario('${user.codigo}')">Editar</button>
            </td>
        `;

        userList.appendChild(row);
    });
}

// Función para filtrar usuarios
function filterUsers(event) {
    event.preventDefault();

    const name = document.querySelector('#name').value.toLowerCase();
    const code = document.querySelector('#code').value.toLowerCase();
    const status = document.querySelector('#status').value.toLowerCase();

    const filteredUsers = users.filter(user => {
        return (
            (name === '' || user.nombre.toLowerCase().includes(name)) &&
            (code === '' || user.codigo.toLowerCase().includes(code)) &&
            (status === '' || user.estatus.toLowerCase() === status)
        );
    });

    displayUsers(filteredUsers);
}

// Funciones de eliminar y editar (puedes implementar la lógica real)
function eliminarUsuario(codigo) {
    alert(`Eliminar usuario con código: ${codigo}`);
}

function editarUsuario(codigo) {
    alert(`Editar usuario con código: ${codigo}`);
}

// Inicializar datos del usuario actual
function initializeCurrentUser() {
    document.querySelector('#user-name').textContent = currentUser.nombre;
    document.querySelector('#user-email').textContent = currentUser.correo;
    document.querySelector('#user-image').src = currentUser.imagen;
}

// Inicializardocument.querySelector('.search-btn').addEventListener('click', filterUsers);
document.addEventListener('DOMContentLoaded', () => {
    displayUsers(users);
    initializeCurrentUser();
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
