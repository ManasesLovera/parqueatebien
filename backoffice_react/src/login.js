import React, {useState} from 'react';
import { useNavigate } from 'react-router-dom';
import logoParqueateBn from './img/LOGO PARQUEATE BN.png'
import logoIntrant from './img/LOGO INTRANT.png'
import './login.css'

export default function Login() {

    let url = 'https://parqueatebiendemo.azurewebsites.net';

    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    //const [error, setError] = useState(null);
    const navigate = useNavigate();

    const handleLogin = async (event) => {
        event.preventDefault();

        try {
            const response = await fetch(`${url}/users/login/`,
                {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json'},
                    body: JSON.stringify({GovernmentID: username, Password: password, Role: 'Admin'})
                }
            );
            if(response.ok) {
                navigate('/backoffice/', {
                    state: {
                        username: username
                    }
                });
            }
            else {
                alert(response.status, response.message)
            }
        }
        catch (error) {
            alert(error);
        }
    }

    return (
        <div className="container">
            <div className="logo">
                <img src={logoParqueateBn} alt="logo"/>
            </div>
            <div className="login">
                <form onSubmit={handleLogin}>
                    <label>Usuario</label>
                    <input id="user" type="text" 
                    placeholder="Ingresar usuario" value={username}
                    onChange={(e) => setUsername(e.target.value)} />
                    <label>Contraseña</label>
                    <input id="password" type="password" 
                    placeholder="Ingresar contraseña" value={password}
                    onChange={(e) => setPassword(e.target.value)} />
                    <button class="btnLogin" type="submit">Ingresar</button>
                </form>
            </div>
            <footer>
                <img src={logoIntrant} alt="INTRANT" />
            </footer>
        </div>
    )
}