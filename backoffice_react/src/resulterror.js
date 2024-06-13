import { useLocation } from 'react-router-dom'
import { Nav } from './nav.js'

export function ResultadoError() {

    const location = useLocation();

    return (
    <div style={{height:'100vh',backgroundColor:'#fefefe'}}>

        <Nav username={location?.state?.username} />
        <h1 style={{marginTop:'30vh'}}>ERROR - No se encontró la placa</h1>

    </div>
)
}