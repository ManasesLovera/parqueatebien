import { useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import { Nav } from './nav';
import './gestionusuarios.css';
import Modal from 'react-modal';
import FormularioCrearUsuarioModal from './formulario_usuario_modal';
import FormularioEditarUsuarioModal from './formulario_editar_usuario_modal';
import FormularioEliminarUsuarioModal from './formulario_eliminar_usuario_modal';
import busqueda from './img/BUSQUEDA.svg';
import deleteButton from './img/delete.png';


export function GestionUsuarios() {
  const location = useLocation();
  const [modalIsOpen, setModalIsOpen] = useState(false);
  const [currentModal, setCurrentModal] = useState(null);
  const [users, setUsers] = useState([]);

  const customStyles = {
    content: {
      margin: 'auto',
      transform: 'translate(-30%, -50%)',
      padding: '20px',
      zIndex: 1000,
    },
    overlay: {
      backgroundColor: 'rgba(0, 0, 0, 0.75)',
      zIndex: 999,
    },
  };

  useEffect(() => {
    const storedUsers = JSON.parse(localStorage.getItem('users')) || [
      {
        codigo: '001',
        nombre: 'Admin',
        tipo: 'Admin',
        status: 'Activo'
      },
      {
        codigo: '002',
        nombre: 'Agente',
        tipo: 'Agente',
        status: 'Activo'
      },
      {
        codigo: '003',
        nombre: 'Agente2',
        tipo: 'Agente',
        status: 'Inactivo'
      }
    ];
    setUsers(storedUsers);
  },[setUsers]);

  const closeModal = () => {
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
          <button onClick={() => openModal('crear')}><span className='symbol'>+</span>Crear nuevo usuario</button>
        </div>
        <div className="filters">
          <h3 className="filter-title">Filtros de consulta</h3>
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
          <button><img src={busqueda} alt='busqueda' /></button>
        </div>

        <h3 className="user-table-title">Listado de usuarios</h3>
        <table className="user-table">
          <thead>
            <tr>
              <th>Código</th>
              <th>Nombre</th>
              <th>Tipo de usuario</th>
              <th>Estatus</th>
              <th></th>
            </tr>
          </thead>
          <tbody id="user-list">
            {
              users.map((user, index) => (<User key={index} {...user} />))
            }
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
        {currentModal === 'crear' && <FormularioCrearUsuarioModal closeModal={closeModal} />}
        {currentModal === 'editar' && <FormularioEditarUsuarioModal closeModal={closeModal} />}
        {currentModal === 'eliminar' && <FormularioEliminarUsuarioModal closeModal={closeModal} />}
      </Modal>
    </>
  );

  function User(props) {
    return (
      <tr>
        <td>{props.codigo}</td>
        <td>{props.nombre}</td>
        <td>{props.tipo}</td>
        <td>{props.status}</td>
        <td className='buttons'>
  
          <button className='btnDelete' onClick={() => openModal('eliminar')}><img src={deleteButton} alt='Delete button'/></button>
          
          <button className='btnEdit' onClick={() => openModal('editar')}>Editar</button>
          
        </td>
      </tr>
    )
  }
  
}


export default GestionUsuarios;
