import LogoParqueateBnAzul from './img/LOGO PARQUEATE BN - AZUL.png';

export function Nav(props) {
    return (
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
                    <span className="flechita">
                        ^
                    </span>
                </span>
            </nav>
    )
}