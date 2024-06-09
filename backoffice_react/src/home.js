import {useNavigate} from 'react-router-dom'

export function Home() {

    const navigate = useNavigate();

    function handleButton() {
        navigate('/login');
    }

    return (
        <>
        <h1>Home</h1>
        <button style={{
            cursor: 'pointer'}} onClick={handleButton}>Click here to login!</button>
        </>
    )
}