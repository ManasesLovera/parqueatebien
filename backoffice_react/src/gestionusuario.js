// import {useState} from 'react';
import {useLocation} from 'react-router-dom'
import {Nav} from './nav'
import './gestionusuarios.css'


export function GestionUsuarios() {

    const location = useLocation();

    return (
        <>
        <Nav username={location?.state?.username}/>
        <div className="container-gestionusuarios">
            <div className="title-section">
                <h1>Gestión de usuarios</h1>
                <button id="agregarUsuarioButton">+Crear nuevo usuario</button>
            </div>
            <div></div>
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

                </tbody>
            </table>
            <div className="pagination">
                <button>&lt;</button>
                <button className="active">1</button>
                <button>2</button>
                <button>3</button>
                <button>&gt;</button>
            </div>
        

            <div id="crearUsuarioPopup" className="popup">
                <div className="popup-content">
                    <span className="close" onclick="closePopup('crearUsuarioPopup')">&times;</span>
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
                        <button className="cancelar" onclick="closePopup('crearUsuarioPopup')">Cancelar</button>
                        <button className="agregar" id="agregarUsuarioBtn" onclick="agregarUsuario()" disabled>Agregar
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
                        <button className="cancelar" onclick="closePopup('editarUsuarioPopup')">Cancelar</button>
                        <button onclick="guardarCambiosUsuario()">Guardar Cambios</button>

                    </div>
                </div>
            </div>
            
            <div id="eliminarUsuarioPopup" className="popup">
                <div className="popup-content">
                    <span className="close" onclick="closePopup('eliminarUsuarioPopup')">&times;</span>
                    <h2>Eliminar Usuario</h2>
                    <p>¿Estás seguro de que deseas eliminar este usuario?</p>
                    <div className="form-row">
                        <button className="cancelar" onclick="closePopup('eliminarUsuarioPopup')">Cancelar</button>
                        <button onclick="eliminarUsuario('codigoDelUsuario')">Eliminar Usuario</button>      
                    </div>
                </div>
            </div>
        </div>
        </>
    )
}