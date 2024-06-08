import { useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import LogoParqueateBnAzul from './img/LOGO PARQUEATE BN - AZUL.png';
import userIcon from './img/user.svg'
import userList from './img/member-list.svg'
import lock from './img/lock.svg'
import logout from './img/sign-out-alt.svg'

export function Nav(props) {
    const [isClicked, setIsClicked] = useState(false);
    return (
        <>
            <nav>
                <span className="logo_nav">
                    <img className="logo_img" src={LogoParqueateBnAzul}  />
                </span>
                <span className="user_data">
                    <img src="https://www.pikpng.com/pngl/m/80-805068_my-profile-icon-blank-profile-picture-circle-clipart.png" alt="My Profile Icon" />
                    <span className="user_info">
                        <p className="username">{props.username}</p>
                        <p className="email">email.com</p>
                    </span>
                    <span className={`flechita ${isClicked ? 'flechitaClicked' : 'flechitaUnClicked'}`}
                    onClick={() => setIsClicked(!isClicked)}>
                        ^
                    </span>
                </span>
                
            </nav>
            <ul className={`options ${isClicked ? 'visible' : ''}`}>
                <li><img src={userIcon} />Gestión de usuarios</li>
                <li><img src={userList} />Gestión de roles</li>
                <li><img src={lock} />Cambiar contraseña</li>
                <li><img src={logout} />Cerrar sesión</li>
            </ul>
        </>
    )
}