import React from 'react';

const FormularioEditarUsuarioModal = (props) => {

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0, 0, 0, 0.5)', zIndex: 999 }}>
          <div style={{ width: '500px', position: 'absolute', top: '800%', left: '80%', transform: 'translate(-50%, -50%)', backgroundColor: 'white', padding: '20px', borderRadius: '10px', boxShadow: '0 0 10px rgba(0, 0, 0, 0.3)' }}>
        
        <div id="editarUsuarioPopup" className="popup">
    <div className="popup-content">
        <span className="close" onclick="closePopup('editarUsuarioPopup')">&times;</span>
        <h2>Editar Usuario</h2>
        <div className="form-row">
            <div className="form-group">
                <label htmlFor="editCodigoUsuario">Código de empleado:</label>
                <input type="text" id="editCodigoUsuario" placeholder="Ingrese el código de empleado" />
            </div>
            <div className="form-group">
            <label htmlFor="editEstatusUsuario">Estatus:</label>
                <select id="editEstatusUsuario">
                    <option value="">Seleccionar</option>
                    <option value="activo">Activo</option>
                    <option value="inactivo">Inactivo</option>
                </select>
            </div>
        </div>
        <div className="form-row">
            <div className="form-group">
            <label htmlFor="editNombreUsuario">Nombre:</label>
                <input type="text" id="editNombreUsuario" placeholder="Ingrese el nombre" />
            </div>
            <div className="form-group">
            <label htmlFor="editApellidoUsuario">Apellido:</label>
                <input type="text" id="editApellidoUsuario" placeholder="Ingrese el apellido" />
            </div>
        </div>
        <div className="form-row">
            <div className="form-group">
            <label htmlFor="editRolUsuario">Asignación de rol:</label>
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
        <button className="cancelar" onClick={()=> { props.closeModal()} }>Cancelar</button>
            <button className="editar" id="editarUsuarioButton" onClick="guardarCambiosUsuario()">Guardar Cambios</button>

        </div>
    </div>
</div>
</div>
    </div>
  );
};
export default FormularioEditarUsuarioModal;