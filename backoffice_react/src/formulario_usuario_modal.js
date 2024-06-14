import React, {useState} from 'react';
import {useNavigate} from 'react-router-dom';
import './formularios.css';

const FormularioUsuarioModal = (props) => {

    const [codigo, setCodigo] = useState('');
    const [nombre, setNombre] = useState('');
    const [apellido, setApellido] = useState('');
    const [tipo, setTipo] = useState('');
    const [status, setStatus] = useState('');
    const navigate = useNavigate();

    function agregarUsuario() {
        if(!codigo || !nombre || !apellido || !tipo || !status){
            alert('Por favor completa todos los campos');
            return;
        }
        const newUser = {
            codigo, nombre, apellido, status, tipo
        }
        const storedUsers = JSON.parse(localStorage.getItem('users')) || [];
        const newUsers = [...storedUsers, newUser];
        localStorage.setItem('users', JSON.stringify(newUsers));
        props.closeModal();
        navigate(0);
    }

    return (
        
          <div style={
            { width: '500px', 
            position: 'absolute', 
            top: '800%', left: '80%', 
            transform: 'translate(-50%, -50%)', 
            backgroundColor: 'white', 
            padding: '20px', 
            borderRadius: '10px', boxShadow: '0 0 10px rgba(0, 0, 0, 0.3)' }}>

      <div className="popup">
                <div className="popup-content">
                    
                    <h2 className='popup-title'>Nuevo Usuario <span className="close" onClick={() => props.closeModal('crearUsuarioPopup')} >&times;</span></h2>
                    <div className="form-row">
                        <div className="form-group">
                            <label className='label'>Código de empleado</label>
                            <input type="text" placeholder="Ingrese el código de empleado" value={codigo} onChange={(e) => setCodigo(e.target.value)}/>
                        </div>
                        <div className="form-group">
                            <label className='label'>Estatus</label>
                            <select value={status} onChange={(e) => setStatus(e.target.value)}>
                                <option value="">Seleccionar</option>
                                <option value="Activo">Activo</option>
                                <option value="Inactivo">Inactivo</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                            <label className='label'>Nombre</label>
                            <input type="text" placeholder="Ingrese el nombre" value={nombre} onChange={(e) => setNombre(e.target.value)}/>
                        </div>
                        <div className="form-group">
                            <label className='label'>Apellido</label>
                            <input type="text" placeholder="Ingrese el apellido" value={apellido} onChange={(e) => setApellido(e.target.value)}/>
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                        <label className='label'>Asignación de rol</label>
                            <select value={tipo} onChange={(e) => setTipo(e.target.value)}>
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
                        <button className="agregar" onClick={agregarUsuario}>Agregar usuario</button>
                    </div>
                </div>
            </div>
            </div>
    
    
  );
};
export default FormularioUsuarioModal;