<<<<<<< HEAD
import { useState } from 'react';
import { useLocation } from 'react-router-dom';
import { Nav } from './nav';
import './gestionusuarios.css';
import Modal from 'react-modal';
import FormularioUsuarioModal from './formulario_usuario_modal';
import FormularioEditarUsuarioModal from './formulario_editar_usuario_modal';
import FormularioEliminarUsuarioModal from './formulario_eliminar_usuario_modal';
=======
// import {useState} from 'react';
import {useLocation} from 'react-router-dom'
import {Nav} from './nav'
import './gestionusuarios.css'

const users = [
    { codigo: '001', nombre: 'Usuario 1', tipo: 'Admin', estatus: 'Activo' },
    { codigo: '002', nombre: 'Usuario 2', tipo: 'Usuario', estatus: 'Inactivo' },
    { codigo: '003', nombre: 'Usuario 3', tipo: 'Usuario', estatus: 'Activo' }
];
>>>>>>> e1e40920f769538ec35c82b245350f63648ecca9

export function GestionUsuarios() {
  const location = useLocation();
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [currentModal, setCurrentModal] = useState(null);

  const customStyles = {
    content: {
      top: '50%',
      left: '50%',
      right: 'auto',
      bottom: 'auto',
      marginRight: '-50%',
      transform: 'translate(-50%, -50%)',
      padding: '20px',
      border: '1px solid #ccc',
      backgroundColor: '#fff',
      borderRadius: '10px',
      boxShadow: '0 5px 15px rgba(0, 0, 0, 0.3)',
      zIndex: 1000,
    },
    overlay: {
      backgroundColor: 'rgba(0, 0, 0, 0.75)',
      zIndex: 999,
    },
  };

<<<<<<< HEAD
  const closeModal = () => {
    console.log("se esta cerrando");
    setModalIsOpen(false);
    setCurrentModal(null);
  };
=======
    function agregarUsuario() {

    }

    function guardarCambiosUsuario() {
        
    }

    function closePopup(e) {
        e.target.style.display = 'none';
    }

    return (
        <>
        <Nav username={location?.state?.username}/>
        <div className="container-gestionusuarios">
            <div className="title-section">
                <h1>Gestión de usuarios</h1>
                <button id="agregarUsuarioButton">+Crear nuevo usuario</button>
            </div>
            <div className="filters">
                <h3 className="filter-title">Filtro de consulta</h3>
                <div className="filter-group">
                    <label for="nombre">Nombre</label>
                    <input type="text" id="nombre" placeholder="Ingresar nombre del usuario" />
                </div>
                <div className="filter-group">
                    <label for="codigo">Código</label>
                    <input type="text" id="codigo" placeholder="Ingresar código del usuario" />
                </div>
                <div className="filter-group">
                    <label for="estatus">Estatus</label>
                    <select id="estatus">
                        <option value="">Seleccionar</option>
                        <option value="activo">Activo</option>
                        <option value="inactivo">Inactivo</option>
                    </select>
                </div>
                <button>Buscar</button>
            </div>
        
            <table className="user-table">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Tipo de usuario</th>
                        <th>Estatus</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody id="user-list">
>>>>>>> e1e40920f769538ec35c82b245350f63648ecca9

  const openModal = (modalType) => {
    setCurrentModal(modalType);
    setModalIsOpen(true);
  };

<<<<<<< HEAD
  // const agregarUsuario = () => {
  //   // Tu lógica para agregar un nuevo usuario aquí
  //   closeModal();
  // };

  // const checkFormCompletion = () => {
  //   // Tu lógica para verificar la completitud del formulario aquí
  // };
=======
            <div id="crearUsuarioPopup" className="popup">
                <div className="popup-content">
                    <span className="close" onClick={closePopup}>&times;</span>
                    <h2>Nuevo Usuario</h2>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="codigoUsuario">Código de empleado:</label>
                            <input type="text" id="codigoUsuario" placeholder="Ingrese el código de empleado" />
                        </div>
                        <div className="form-group">
                            <label for="estatusUsuario">Estatus:</label>
                            <select id="estatusUsuario">
                                <option value="">Seleccionar</option>
                                <option value="activo">Activo</option>
                                <option value="inactivo">Inactivo</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="nombreUsuario">Nombre:</label>
                            <input type="text" id="nombreUsuario" placeholder="Ingrese el nombre" />
                        </div>
                        <div className="form-group">
                            <label for="apellidoUsuario">Apellido:</label>
                            <input type="text" id="apellidoUsuario" placeholder="Ingrese el apellido" />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="rolUsuario">Asignación de rol:</label>
                            <select id="rolUsuario">
                                <option value="">Seleccionar</option>
                                <option value="agente">Agente</option>
                                <option value="admin">Admin</option>
                                <option value="supervisor">Supervisor</option>
                                <option value="grua">Grua</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <button className="cancelar" onClick={closePopup}>Cancelar</button>
                        <button className="agregar" id="agregarUsuarioBtn" onClick={agregarUsuario} disabled>Agregar
                            usuario</button>
                    </div>
                </div>
            </div>

            <div id="editarUsuarioPopup" className="popup">
                <div className="popup-content">
                    <span className="close" onclick="closePopup('editarUsuarioPopup')">&times;</span>
                    <h2>Editar Usuario</h2>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="editCodigoUsuario">Código de empleado:</label>
                            <input type="text" id="editCodigoUsuario" placeholder="Ingrese el código de empleado" />
                        </div>
                        <div className="form-group">
                            <label for="editEstatusUsuario">Estatus:</label>
                            <select id="editEstatusUsuario">
                                <option value="">Seleccionar</option>
                                <option value="activo">Activo</option>
                                <option value="inactivo">Inactivo</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="editNombreUsuario">Nombre:</label>
                            <input type="text" id="editNombreUsuario" placeholder="Ingrese el nombre" />
                        </div>
                        <div className="form-group">
                            <label for="editApellidoUsuario">Apellido:</label>
                            <input type="text" id="editApellidoUsuario" placeholder="Ingrese el apellido" />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label for="editRolUsuario">Asignación de rol:</label>
                            <select id="editRolUsuario">
                                <option value="">Seleccionar</option>
                                <option value="agente">Agente</option>
                                <option value="admin">Admin</option>
                                <option value="supervisor">Supervisor</option>
                                <option value="grua">Grua</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <button className="cancelar" onClick={closePopup}>Cancelar</button>
                        <button onClick={guardarCambiosUsuario}>Guardar Cambios</button>
>>>>>>> e1e40920f769538ec35c82b245350f63648ecca9

  return (
    <>
      <Nav username={location?.state?.username} />
      <div className="container-gestionusuarios">
        <div className="title-section">
          <h1>Gestión de usuarios</h1>
          <button onClick={() => openModal('crear')}>+Crear nuevo usuario</button>
        </div>
        <div className="filters">
          <h3 className="filter-title">Filtro de consulta</h3>
          <div className="filter-group">
            <label htmlFor="nombre">Nombre</label>
            <input type="text" id="nombre" placeholder="Ingresar nombre del usuario" />
          </div>
          <div className="filter-group">
            <label htmlFor="codigo">Código</label>
            <input type="text" id="codigo" placeholder="Ingresar código del usuario" />
          </div>
          <div className="filter-group">
            <label htmlFor="estatus">Estatus</label>
            <select id="estatus">
              <option value="">Seleccionar</option>
              <option value="activo">Activo</option>
              <option value="inactivo">Inactivo</option>
            </select>
          </div>
          <button>Buscar</button>
        </div>

        <h3 className="user-table-title">Listado de usuarios</h3>
        <table className="user-table">
          <thead>
            <tr>
              <th>Código</th>
              <th>Nombre</th>
              <th>Tipo de usuario</th>
              <th>Estatus</th>
            </tr>
          </thead>
          <tbody id="user-list">
            <tr>
              <td>Código1</td>
              <td>Nombre1</td>
              <td>Tipo1</td>
              <td>Activo</td>
              <td>
                <div className= "edit-button">
                <button onClick={() => openModal('editar')}>Editar</button>
                </div>
<<<<<<< HEAD
                <div className= "delet-button">
                <button id="delet-button" onClick={() => openModal('eliminar')}>Eliminar</button>
=======
            </div>
            
            <div id="eliminarUsuarioPopup" className="popup">
                <div className="popup-content">
                    <span className="close" onclick="closePopup('eliminarUsuarioPopup')">&times;</span>
                    <h2>Eliminar Usuario</h2>
                    <p>¿Estás seguro de que deseas eliminar este usuario?</p>
                    <div className="form-row">
                        <button className="cancelar" onClick={closePopup}>Cancelar</button>
                        <button onclick="eliminarUsuario('codigoDelUsuario')">Eliminar Usuario</button>      
                    </div>
>>>>>>> e1e40920f769538ec35c82b245350f63648ecca9
                </div>
              </td>
            </tr>
            {/* Agrega más filas de usuarios aquí */}
          </tbody>
        </table>
        <div className="pagination">
          <button>&lt;</button>
          <button className="active">1</button>
          <button>2</button>
          <button>3</button>
          <button>&gt;</button>
        </div>
      </div>

      <Modal
        isOpen={modalIsOpen}
        onRequestClose={closeModal}
        className="mi-clase-de-popup"
        style={customStyles}
      >
        {currentModal === 'crear' && <FormularioUsuarioModal closeModal={closeModal} />}
        {currentModal === 'editar' && <FormularioEditarUsuarioModal closeModal={closeModal} />}
        {currentModal === 'eliminar' && <FormularioEliminarUsuarioModal closeModal={closeModal} />}
      </Modal>
    </>
  );
}

export default GestionUsuarios;
