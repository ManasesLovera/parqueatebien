// import React, { useState } from 'react';

// function Popups() {
    
//     const [crearUsuarioPopupVisible, setCrearUsuarioPopupVisible] = useState(false);
//     const [editarUsuarioPopupVisible, setEditarUsuarioPopupVisible] = useState(false);
//     const [eliminarUsuarioPopupVisible, setEliminarUsuarioPopupVisible] = useState(false);

  
//     const openCrearUsuarioPopup = () => {
//         setCrearUsuarioPopupVisible(true);
//     }

//     const closeCrearUsuarioPopup = () => {
//         setCrearUsuarioPopupVisible(false);
//     }

//     const openEditarUsuarioPopup = () => {
//         setEditarUsuarioPopupVisible(true);
//     }

//     const closeEditarUsuarioPopup = () => {
//         setEditarUsuarioPopupVisible(false);
//     }

//     const openEliminarUsuarioPopup = () => {
//         setEliminarUsuarioPopupVisible(true);
//     }

//     const closeEliminarUsuarioPopup = () => {
//         setEliminarUsuarioPopupVisible(false);
//     }

//     const guardarCambiosUsuario = () => {
//         const codigo = document.getElementById('editCodigoUsuario').value;
//         const estatus = document.getElementById('editEstatusUsuario').value;
//         const nombre = document.getElementById('editNombreUsuario').value;
//         const apellido = document.getElementById('editApellidoUsuario').value;
//         const rol = document.getElementById('editRolUsuario').value;
        
        
//         const usuarioEditado = {
//             codigo: codigo,
//             estatus: estatus,
//             nombre: nombre,
//             apellido: apellido,
//             rol: rol
//         };
    
//         fetch('url_para_guardar_cambios', {
//             method: 'PUT', // Método HTTP para actualizar los datos
//             headers: {
//                 'Content-Type': 'application/json' // Especificar el tipo de contenido JSON
//             },
//             body: JSON.stringify(usuarioEditado) // Convertir el objeto a formato JSON
//         })
//         .then(response => {
//             if (response.ok) {

//                 console.log('Cambios guardados correctamente');
//             } else {

//                 console.error('Error al guardar cambios:', response.statusText);
//             }
//             closePopup('editarUsuarioPopup');
//         })
//         .catch(error => {
//             console.error('Error al procesar la solicitud:', error);
//         });
//     }

//     const eliminarUsuario = (codigoUsuario) => {
    
//         fetch(`url_para_eliminar_usuario/${codigoUsuario}`, {
//             method: 'DELETE', // Método HTTP para eliminar el usuario
//         })
//         .then(response => {
//             if (response.ok) {

//                 console.log('Usuario eliminado correctamente');
//             } else {

//                 console.error('Error al eliminar usuario:', response.statusText);
//             }
//             closePopup('eliminarUsuarioPopup');
//         })
//         .catch(error => {
//             console.error('Error al procesar la solicitud:', error);
//         });

//     const agregarUsuario = () => {
//         const codigo = document.getElementById('codigoUsuario').value;
//         const estatus = document.getElementById('estatusUsuario').value;
//         const nombre = document.getElementById('nombreUsuario').value;
//         const apellido = document.getElementById('apellidoUsuario').value;
//         const rol = document.getElementById('rolUsuario').value;
    
//         const nuevoUsuario = {
//             codigo: codigo,
//             estatus: estatus,
//             nombre: nombre,
//             apellido: apellido,
//             rol: rol
//         };
    
//         fetch('url_para_agregar_usuario', {
//             method: 'POST', // Método HTTP para agregar el usuario
//             headers: {
//                 'Content-Type': 'application/json' // Especificar el tipo de contenido JSON
//             },
//             body: JSON.stringify(nuevoUsuario) // Convertir el objeto a formato JSON
//         })
//         .then(response => {
//             if (response.ok) {
//                 console.log('Usuario agregado correctamente');
//             } else {
//                 console.error('Error al agregar usuario:', response.statusText);
//             }
//             closePopup('crearUsuarioPopup');
//         })
//         .catch(error => {
//             console.error('Error al procesar la solicitud:', error);
//         });
//     }

//     return (
//         <>
//         {/* Popup de crear usuario */}
//         {crearUsuarioPopupVisible && (
//             <div id="crearUsuarioPopup" className="popup">
//                 {/* Contenido del popup de crear usuario */}
//             </div>
//         )}

//         {/* Popup de editar usuario */}
//         {editarUsuarioPopupVisible && (
//             <div id="editarUsuarioPopup" className="popup">
//                 {/* Contenido del popup de editar usuario */}
//             </div>
//         )}

//         {/* Popup de eliminar usuario */}
//         {eliminarUsuarioPopupVisible && (
//             <div id="eliminarUsuarioPopup" className="popup">
//                 {/* Contenido del popup de eliminar usuario */}
//             </div>
//         )}


//         {/* Botones o elementos que abren los popups */}
//         <button onClick={openCrearUsuarioPopup}>Abrir popup de crear usuario</button>
//         <button onClick={openEditarUsuarioPopup}>Abrir popup de editar usuario</button>
//         <button onClick={openEliminarUsuarioPopup}>Abrir popup de eliminar usuario</button>
//     </>
// );
//     }
// }

// export default Popups;