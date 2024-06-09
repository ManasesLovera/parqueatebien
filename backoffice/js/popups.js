// Función para abrir el popup
function openPopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "block";
}

// Función para cerrar el popup
function closePopup(popupId) {
    const popup = document.getElementById(popupId);
    popup.style.display = "none";
}
function openEditarUsuarioPopup() {
    openPopup('editarUsuarioPopup');
}

function openEliminarUsuarioPopup() {
    openPopup('eliminarUsuarioPopup');
}

function guardarCambiosUsuario() {
    // Aquí puedes obtener los valores de los campos del formulario de edición
    var codigo = document.getElementById('editCodigoUsuario').value;
    var estatus = document.getElementById('editEstatusUsuario').value;
    var nombre = document.getElementById('editNombreUsuario').value;
    var apellido = document.getElementById('editApellidoUsuario').value;
    var rol = document.getElementById('editRolUsuario').value;
    
    // Aquí puedes realizar la lógica para guardar los cambios del usuario editado
    // Por ejemplo, puedes enviar los datos a través de una solicitud AJAX

    // Crear un objeto con los datos del usuario editado
    var usuarioEditado = {
        codigo: codigo,
        estatus: estatus,
        nombre: nombre,
        apellido: apellido,
        rol: rol
    };

    // Ejemplo de solicitud AJAX utilizando la API Fetch
    fetch('url_para_guardar_cambios', {
        method: 'PUT', // Método HTTP para actualizar los datos
        headers: {
            'Content-Type': 'application/json' // Especificar el tipo de contenido JSON
        },
        body: JSON.stringify(usuarioEditado) // Convertir el objeto a formato JSON
    })
    .then(response => {
        if (response.ok) {
            // La solicitud se completó correctamente
            console.log('Cambios guardados correctamente');
            // Puedes realizar alguna acción adicional aquí, como actualizar la lista de usuarios
        } else {
            // Hubo un error al procesar la solicitud
            console.error('Error al guardar cambios:', response.statusText);
            // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
        }
        // Cerrar el popup después de guardar los cambios
        closePopup('editarUsuarioPopup');
    })
    .catch(error => {
        console.error('Error al procesar la solicitud:', error);
        // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
    });


    // Cerrar el popup después de guardar los cambios
    closePopup('editarUsuarioPopup');
}

// Función para eliminar un usuario
function eliminarUsuario(codigoUsuario) {
    // Aquí puedes realizar la lógica para eliminar el usuario
    // Por ejemplo, puedes enviar una solicitud AJAX para eliminar el usuario

    // Ejemplo de solicitud AJAX utilizando la API Fetch
    fetch('url_para_eliminar_usuario/' + codigoUsuario, {
        method: 'DELETE', // Método HTTP para eliminar el usuario
    })
    .then(response => {
        if (response.ok) {
            // La solicitud se completó correctamente
            console.log('Usuario eliminado correctamente');
            // Puedes realizar alguna acción adicional aquí, como actualizar la lista de usuarios
        } else {
            // Hubo un error al procesar la solicitud
            console.error('Error al eliminar usuario:', response.statusText);
            // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
        }
        // Cerrar el popup después de eliminar el usuario
        closePopup('eliminarUsuarioPopup');
    })
    .catch(error => {
        console.error('Error al procesar la solicitud:', error);
        // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
    });
}

// Función para agregar un nuevo usuario
// Función para agregar un nuevo usuario
function agregarUsuario() {
    // Obtener los valores de los campos del formulario
    var codigo = document.getElementById('codigoUsuario').value;
    var estatus = document.getElementById('estatusUsuario').value;
    var nombre = document.getElementById('nombreUsuario').value;
    var apellido = document.getElementById('apellidoUsuario').value;
    var rol = document.getElementById('rolUsuario').value;

    // Crear un objeto con los datos del usuario
    var nuevoUsuario = {
        codigo: codigo,
        estatus: estatus,
        nombre: nombre,
        apellido: apellido,
        rol: rol
    };

    // Realizar la solicitud AJAX para agregar el usuario
    var xhr = new XMLHttpRequest();
    xhr.open('POST', 'url_para_agregar_usuario', true); // Reemplaza 'url_para_agregar_usuario' con la URL de tu servidor
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                // La solicitud se completó correctamente
                console.log('Usuario agregado correctamente');
                // Puedes realizar alguna acción adicional aquí, como actualizar la lista de usuarios
            } else {
                // Hubo un error al procesar la solicitud
                console.error('Error al agregar usuario:', xhr.statusText);
                // Puedes mostrar un mensaje de error al usuario o realizar alguna otra acción de manejo de errores
            }
            // Cerrar el popup después de agregar el usuario (si es necesario)
            closePopup('crearUsuarioPopup');
        }
    };
    xhr.send(JSON.stringify(nuevoUsuario));
}

// Función para verificar la completitud del formulario de creación de usuario
function checkFormCompletion() {
    const codigo = document.getElementById('codigoUsuario').value;
    const estatus = document.getElementById('estatusUsuario').value;
    const nombre = document.getElementById('nombreUsuario').value;
    const apellido = document.getElementById('apellidoUsuario').value;
    const rol = document.getElementById('rolUsuario').value;
    const agregarUsuarioBtn = document.getElementById('agregarUsuarioButton');

    if (codigo && estatus && nombre && apellido && rol) {
        agregarUsuarioBtn.disabled = false;
        agregarUsuarioBtn.style.backgroundColor = '#007bff'; // Habilitar y cambiar el color
    } else {
        agregarUsuarioBtn.disabled = true;
        agregarUsuarioBtn.style.backgroundColor = '#ccc'; // Deshabilitar y cambiar el color
    }
}

document.addEventListener('DOMContentLoaded', function() {
    const agregarUsuarioButton = document.getElementById('agregarUsuarioButton');
    agregarUsuarioButton.addEventListener('click', function() {
        openPopup('crearUsuarioPopup');
    });

    const inputs = document.querySelectorAll('#crearUsuarioPopup input, #crearUsuarioPopup select');
    inputs.forEach(input => {
        input.addEventListener('input', checkFormCompletion);
    });
});
