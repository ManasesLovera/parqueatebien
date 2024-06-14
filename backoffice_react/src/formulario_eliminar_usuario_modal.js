import React, {useState, useEffect} from 'react';
import {useNavigate} from 'react-router-dom';
import './formularios.css';

const FormularioEliminarUsuarioModal = (props) => {

    const [users, setUsers] = useState([]);
    const navigate = useNavigate();

    useEffect( () => {
        setUsers(JSON.parse(localStorage.getItem('users')) || []);
    }, [setUsers]);

    function eliminarUsuario() {
        const toDelete = JSON.parse(localStorage.getItem('toDelete')) || '';
        if(toDelete === '') {
            alert('No hay usuario para eliminar');
            return;
        }
        const userToDelete = users.find(user => user.nombre === toDelete);
        if(!userToDelete) {
            alert(`El usuario ${toDelete} no existe`);
            return;
        }
        const newUsers = users.filter(user => user.nombre !== toDelete)
        setUsers(newUsers);
        localStorage.setItem('users', JSON.stringify(newUsers));
        localStorage.removeItem('toDelete');
        props.closeModal();
        navigate(0);
    }

    return (
    <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0, 0, 0, 0.5)', zIndex: 999 }}>
        <div style={{ width: '500px', position: 'absolute', top: '800%', left: '80%', transform: 'translate(-50%, -50%)', backgroundColor: 'white', padding: '20px', borderRadius: '10px', boxShadow: '0 0 10px rgba(0, 0, 0, 0.3)' }}> 
        <div id="eliminarUsuariopopup" className="popup">
            <div className="popup-content">
                
                <h2 className='popup-title'>Eliminar Usuario <span className="close" onClick={() => props.closeModal('eliminar')}>&times;</span></h2>
                <p>¿Estás seguro de que deseas eliminar este usuario?</p>
                <div className="form-row">
                    <button className="cancelar" onClick={()=> props.closeModal('eliminar')}>Cancelar</button>
                    <button className="eliminar" onClick={eliminarUsuario}>Confirmar</button>   
                </div>
            </div>
          </div>
        </div>
    </div>
  );
};
export default FormularioEliminarUsuarioModal;