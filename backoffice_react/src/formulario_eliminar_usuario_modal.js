import React from 'react';

const FormularioEliminarUsuarioModal = (props) => {

    return (
        <div style={{ display: 'flex', justifyContent: 'center', alignItems: 'center', position: 'fixed', top: 0, left: 0, width: '100%', height: '100%', backgroundColor: 'rgba(0, 0, 0, 0.5)', zIndex: 999 }}>
          <div style={{ width: '500px', position: 'absolute', top: '800%', left: '80%', transform: 'translate(-50%, -50%)', backgroundColor: 'white', padding: '20px', borderRadius: '10px', boxShadow: '0 0 10px rgba(0, 0, 0, 0.3)' }}> <div id="eliminarUsuariopopup" className="popup">
<div className="popup-content">
    <span className="close" onclick="closePopup('eliminarUsuarioPopup')">&times;</span>
    <h2>Eliminar Usuario</h2>
    <p>¿Estás seguro de que deseas eliminar este usuario?</p>
    <div className="form-row">
        <button className="cancelar" onClick={()=> { props.closeModal()} }>Cancelar</button>
        <button className="eliminar" id="eliminarUsuarioButton" onClick="eliminarUsuario()">Eliminar</button>   
    </div>
</div>
</div>
</div>
    </div>
  );
};
export default FormularioEliminarUsuarioModal;