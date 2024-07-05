# Backend Docs

#### Dependencies/libraries

`Microsoft.EntityFrameworkCore`
`Microsoft.EntityFrameworkCore.Design`
`Microsoft.EntityFrameworkCore.Sqlite`
`Microsoft.EntityFrameworkCore.Tools`
`"Microsoft.IdentityModel.Tokens`
`Portable.BouncyCastle`
`AutoMapper`
`BCrypt.Net-Next`
`FluentValidation`
`Microsoft.AspNetCore.Authentication.JwtBearer`
`Microsoft.IdentityModel.Tokens`
`System.IdentityModel.Tokens.Jwt`
`Swashbuckle.AspNetCore`

## Endpoints

### Reportes

1. GET / -> `/api/reportes`:
	- Returns an array of Reports
    - 200 Ok
```json
[
    {
        "registrationNumber": string,
        "licensePlate": string,
        "registrationDocument": string,
        "vehicleType": string,
        "vehicleColor": string,
        "model": string,
        "year": string,
        "reference": string,
        "status": string,
        "reportedBy": string,
        "reportedDate": string,
        "towedByCraneDate": string | null,
        "arrivalAtParkinglot": string | null,
        "releaseDate": string | null,
        "releaseBy": string | null,
        "lat": string,
        "lon": string,
        "photos": [
            {
                "file": base64 encoded string,
                "fileType": string
            }
        ]
    }
]
```
2. GET / -> `/api/reporte/{licensePlate}`:
    - Returns one the last report with the current licensePlate
    - 200 Ok, 404 NotFound, 400 BadRequest (Invalid LicensePlate)
``` json
{
    "registrationNumber": string,
    "licensePlate": string,
    "registrationDocument": string,
    "vehicleType": string,
    "vehicleColor": string,
    "model": string,
    "year": string,
    "reference": string,
    "status": string,
    "reportedBy": string,
    "reportedDate": string,
    "towedByCraneDate": string | null,
    "arrivalAtParkinglot": string | null,
    "releaseDate": string | null,
    "releaseBy": string | null,
    "lat": string,
    "lon": string,
    "photos": [
        {
            "file": base64 encoded string,
            "fileType": string
        }
    ]
}
```
3. POST / -> `/api/reporte`:
    - Receive a report and return it back with more data
    - 201 Created, 400 BadRequest (Invalid Data)
#### How you must send the data
```json
{
    "licensePlate": string,
    "registrationDocument": string,
    "vehicleType": string,
    "vehicleColor": string,
    "model": string,
    "year": string,
    "reference": string,
    "lat": string,
    "lon": string,
    "reportedBy": string,
    "photos": [
        {
            "file": base 64,
            "fileType": string
        }
    ]
}
```
#### How you will receive it back
```json
{
    "registrationNumber": string,
    "licensePlate": string,
    "registrationDocument": string,
    "vehicleType": string,
    "vehicleColor": string,
    "model": string,
    "year": string,
    "reference": string,
    "status": string,
    "reportedBy": string,
    "reportedDate": string,
    "towedByCraneDate": string,
    "arrivalAtParkinglot": string,
    "releaseDate": string,
    "releasedBy": string,
    "lat": string,
    "lon": string,
    "photos": [
        {
            "file": base 64,
            "fileType": string
        }
    ]
}
```
4. DELETE / -> `/api/reporte/{licensePlate}`:
    - Delete the last report with the licensePlate in the route.
    - 200 OK, 404 NotFound, 400 BadRequest (Invalid LicensePlate)

5. PUT / -> `/api/reporte/actualizarEstado`:
    - Update the status of the report ['Reportado', 'Incautado por grua', 'Retenido', 'Liberado']
    - 200 Ok, 404 NotFound, 409 Conflict (can't be modified to the especified status)
```json
{
    "licensePlate": string,
    "newStatus": string,
    "username": string
}
```

### Usuario (Admin, Agente, Grua)

#### Registrar usuario
1. POST / -> `/api/user/register`:
    - This will register the user with the data provided
    - 200 OK, 400 BadRequest (Invalid data), 409 Conflict (User (EmployeeCode or Username) exist, craneCompany doesnt exist)
```json
{
    "employeeCode": string,
    "name": string,
    "lastname": string,
    "username": string,
    "password": string,
    "status": boolean
    "role": string,
    "craneCompany": string | null //This will be null if it's not a craneUser
}
```
#### Login
2. POST / -> `/api/user/login`:
    - Valid the user info and returns a token or error
    - 200 OK (with token), 409 Conflict (Username or password wrong), 400 BadRequest (Role doesnt exist)
```json
{
    "username": string,
    "password": string,
    "role": string
}
```
`Then you will receive a string token you must add in the headers:Authorization`

3. GET / -> `/api/users`:
    - Get all users
    - 200 Ok, 500 Server error
```json
[
    {
        "id": int,
        "employeeCode": string,
        "name": string,
        "lastname": string,
        "username": string,
        "status": boolean,
        "role": string,
        "craneCompany": string | null
    }
]
```
4. GET / -> `/api/users/{username}`:
    - Returns a single user with the username.
    - 200 Ok, 404 NotFound
```json
{
    "id": int,
    "employeeCode": string,
    "name": string,
    "lastname": string,
    "username": string,
    "status": boolean,
    "role": string,
    "craneCompany": string | null
}
```
5. PUT / -> `/api/user/changePassword`:
    - Change the password of the user
    - 200 Ok, 404 NotFound (Username)
```json
{
    "username": string,
    "password": string // new password
}

```
6. DELETE / -> `/api/user/{username}`:
    - Deletes user with username
    - 200 Ok, 404 NotFound

### Empresas de grua

1. GET / -> `/api/craneCompanies/`:
    - Get a list of all crane companies
    - 200 Ok([])
```json
[
    {
        "id": int,
        "RNC": string,
        "companyName": string,
        "phoneNumber": string,
        "amountCraneAgents": int
    }
]
```
2. GET / -> `/api/craneCompany/{rnc}`:
    - Get single craneCompany by RNC
    - 200 Ok, 404 NotFound
```json
{
    "id": int,
    "RNC": string,
    "companyName": string,
    "phoneNumber": string,
    "amountCraneAgents": int
}
```
3. POST / -> `/api/craneCompany`:
    - Add new crane company
    - 200 Ok({message}), 400 BadRequest (must receive rnc, companyName and phoneNumber), 409 Conflict (already exist)
```json
{
    "RNC": string,
    "companyName": string,
    "phoneNumber": string,
}
```
4. DELETE / -> `/api/craneCompany/{rnc}`:
    - Delete crane company by RNC
    - 200 Ok, 404 NotFound

### Ciudadanos

1. GET / -> `/api/citizens`:
    - Get all citizens
    - 200 Ok

1. POST / -> `/api/citizen/register`:
    - Register citizen
    - 200 Ok, 409 Conflict({message}) already exists, 400 BadRequest (Invalid data)
```json
{
    "governmentId": string,
    "name": string,
    "lastname": string,
    "email": string,
    "password": string,
    "vehicles": [
        {
            "licensePlate": string,
            "registrationDocument": string,
            "model": string,
            "year": string,
            "color": string
        }
    ]
}
```
2. POST / -> `/api/citizen/login`:
    - Login citizen
    - 200 Ok(token), 409 Conflict({message})
```json
{
    "governmentId": string,
    "password": string
}
```
4. PUT / -> `/api/citizen/updateStatus{governmentId}`:
    - Update status to true if false and to false if true
    - 200 Ok, 404 NotFound