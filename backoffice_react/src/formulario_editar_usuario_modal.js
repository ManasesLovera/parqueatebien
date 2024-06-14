import React, {useState,useEffect} from 'react';
import {useNavigate} from 'react-router-dom';
import './formularios.css'

const FormularioEditarUsuarioModal = (props) => {

    const [userToEdit, setUserToEdit] = useState({});
    const [storedUsers, setStoredUsers] = useState([]);
    const [nombre, setNombre] = useState('');
    const [apellido, setApellido] = useState('');
    const [status, setStatus] = useState('');
    const [tipo, setTipo] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        setStoredUsers(JSON.parse(localStorage.getItem('users')) || []);
        setUserToEdit(JSON.parse(localStorage.getItem('toEdit')) || '');
    },[setStoredUsers,setUserToEdit]);

    function editarUsuario() {
        if(!nombre || !apellido || !tipo || !status){
            alert('Hay campos vacios!');
            return;
        }
        const newUser = {
            codigo: userToEdit.codigo, nombre, apellido, status, tipo
        }
        const newUsers = storedUsers.map( (user) => {
            if(user.codigo === newUser.codigo) {
                return newUser;
            }
            return user;
        })

        localStorage.setItem('users', JSON.stringify(newUsers));

        navigate(0);
    }

    return (
<div className='container-modal'>
<div className='modal'>
    <div className="popup">
        <div className="popup-content">
            <h2 className='popup-title'>Editar Usuario <span className="close" onClick={() => props.closeModal()}>&times;</span></h2>
            <div className="form-row">
                <div className="form-group">
                    <label className='label'>Código de empleado</label>
                    <input type="text" placeholder="Ingrese el código de empleado" 
                    value={userToEdit.codigo} readonly/>
                </div>
                <div className="form-group">
                <label className='label'>Estatus</label>
                    <select 
                    value={status} onChange={(e) => setStatus(e.target.value)} >
                        <option value="">Seleccionar</option>
                        <option value="Activo">Activo</option>
                        <option value="Inactivo">Inactivo</option>
                    </select>
                </div>
            </div>
            <div className="form-row">
                <div className="form-group">
                <label className='label'>Nombre</label>
                    <input type="text" id="editNombreUsuario" placeholder="Ingrese el nombre"
                    value={nombre} onChange={(e) => setNombre(e.target.value)} />
                </div>
                <div className="form-group">
                <label className='label'>Apellido</label>
                    <input type="text" placeholder="Ingrese el apellido"
                    value={apellido} onChange={(e) => setApellido(e.target.value)} />
                </div>
            </div>
            <div className="form-row">
                <div className="form-group">
                <label className='label'>Asignación de rol</label>
                    <select
                    value={tipo} onChange={(e) => setTipo(e.target.value)} >
                        <option value="">Seleccionar</option>
                        <option value="Agente">Agente</option>
                        <option value="Admin">Admin</option>
                        <option value="Supervisor">Supervisor</option>
                        <option value="Grua">Grua</option>
                    </select>
                </div>
            </div>
            <div className="form-row">
            <button className="cancelar" onClick={()=> { props.closeModal()} }>Cancelar</button>
                <button className="editar" onClick={editarUsuario}>Guardar Cambios</button>

            </div>
        </div>
    </div>
</div>
</div>
  );
};
export default FormularioEditarUsuarioModal;