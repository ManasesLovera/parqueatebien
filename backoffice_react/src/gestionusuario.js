import { useState } from 'react';
import { useLocation } from 'react-router-dom';
import { Nav } from './nav';
import './gestionusuarios.css';
import Modal from 'react-modal';
import FormularioUsuarioModal from './formulario_usuario_modal';
import FormularioEditarUsuarioModal from './formulario_editar_usuario_modal';
import FormularioEliminarUsuarioModal from './formulario_eliminar_usuario_modal';


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


  const closeModal = () => {
    console.log("se esta cerrando");
    setModalIsOpen(false);
    setCurrentModal(null);
  };

  const openModal = (modalType) => {
    setCurrentModal(modalType);
    setModalIsOpen(true);
  };


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

                <div className= "delet-button">
                <button id="delet-button" onClick={() => openModal('eliminar')}>Eliminar</button>
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
