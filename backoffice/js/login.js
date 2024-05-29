const btnLogin = document.getElementById('btnLogin');

btnLogin.addEventListener('click', async (e) =>{
    e.preventDefault();

    const user = document.getElementById('user').value;
    const password = document.getElementById('password').value;

    if (user.length == 0 || password.length == 0)
        return;

    const result = await inputFormValidator();

    console.log(result)

    if(result == "OK") 
        window.location.href = "../html/consultarplaca.html";
    else 
        alert(result)
})

async function inputFormValidator() {
    try {
        const response = await fetch('http://127.0.0.1/:8089/admin/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            withCredentials: true,    
            crossorigin: true,
            mode: 'no-cors',
            body: JSON.stringify({"governmentID": user, "Password": password})
        });

        console.log(response)

        switch (response.status) {
            case 200:
                return "OK";
            case 404:
                return "User was not found";
            case 401:
                return "Wrong password";
            case 400:
                return "Invalid data";
            case 500:
                return "SERVER ERROR";
            default:
                return response.status
        }
    }
    catch (error) {
        alert(error);
    }
}