import { useEffect } from 'react';
import { useLocation, useNavigate } from 'react-router-dom'
import { Nav } from './nav.js'

export function ResultadoError() {

    const location = useLocation();
    const navigate = useNavigate();
    const username = location?.state?.username;

    useEffect( () => {
        if(username === null || username === undefined) {
            navigate('/login', {state: {username: username}});
            return;
        }
    },[navigate, username])

    
    return (
        <div style={{height:'100vh',backgroundColor:'#fefefe'}}>
    
            <Nav username={username} />
            <h1 style={{marginTop:'30vh'}}>ERROR - No se encontró la placa</h1>
    
        </div>
        )

    
}