import React from 'react';
import './formularios.css';

const FormularioUsuarioModal = (props) => {

    function agregarUsuario() {
        alert('Usuario agregado!')
        console.log('Usuario agregado')
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
                            <input type="text" placeholder="Ingrese el código de empleado" />
                        </div>
                        <div className="form-group">
                            <label className='label'>Estatus</label>
                            <select>
                                <option value="">Seleccionar</option>
                                <option value="activo">Activo</option>
                                <option value="inactivo">Inactivo</option>
                            </select>
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                        <label className='label'>Nombre</label>
                            <input type="text" placeholder="Ingrese el nombre" />
                        </div>
                        <div className="form-group">
                        <label className='label'>Apellido</label>
                            <input type="text" placeholder="Ingrese el apellido" />
                        </div>
                    </div>
                    <div className="form-row">
                        <div className="form-group">
                        <label className='label'>Asignación de rol</label>
                            <select>
                                <option value="">Seleccionar</option>
                                <option value="agente">Agente</option>
                                <option value="admin">Admin</option>
                                <option value="supervisor">Supervisor</option>
                                <option value="grua">Grua</option>
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