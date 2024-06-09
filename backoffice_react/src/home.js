import { useNavigate } from 'react-router-dom'

export function Home() {
    const navigate = useNavigate();
    navigate('/login');
    return <button>Click aqui</button>
}