const btnLogin = document.getElementById('btnLogin');
btnLogin.addEventListener('click', async (e) =>{
    e.preventDefault();
    let userInput = document.getElementById('user').value;
    let passwordInput = document.getElementById('password').value;

    if (userInput.trim() == '' || passwordInput.trim() == ''){
        alert("Please enter username and password");
        return;
    }
    const result = await inputFormValidator(userInput, passwordInput);

    console.log(result)

    if(result == "OK") {
        alert("WELCOME!")
        window.location.href = "../html/consultarplaca.html";
    }
    else 
        alert(result)
})

async function inputFormValidator(user, password) {
    try {
        console.log({"governmentID": user, "password": password});
        const response = await fetch('http://localhost:8089/admin/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
                //,'Access-Control-Allow-Origin': '*'
            },
            body: JSON.stringify({governmentID: user, password: password})
        });

        switch (response.status) {
            case 200:
                return "OK";
            case 404:
                return "User does not exist";
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