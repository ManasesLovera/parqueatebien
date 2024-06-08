import { useLocation, useNavigate } from 'react-router-dom'

export function ResultadoError() {

    const location = useLocation();
    const navigate = useNavigate();

    if(location?.state?.licensePlate == null) {
        navigate('/backoffice');
        return;
    }

    if(location?.state?.username == null) {
        navigate('/login');
        return;
    }

    return <h1>ERROR</h1>
}