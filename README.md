# demo-orion-tek
Demo para la aplicacion que estamos haciendo de incautacion de vehiculos.

## Backend docs

### Endpoints for citizen:

> Validation for LicensePlate: It can only contain uppercase letters, numbers and dashes.

1. GET / -> `"/api/reportes"`:
    - This will return an array of objects with the whole data with this format:
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
            },
            ...
        ]
    },
...
]
```
2. GET / -> `"/ciudadanos/{licensePlate}"`:
    - This will return a citizen that matches with the licensePlate inserted into the route passed.
```json
{
    "LicensePlate": string,
    "VehicleType": string,
    "VehicleColor": string,
    "Address": string,
    "Status": string,
    "Lat": string,
    "Lon": string,
    "Photos": [
                {
                    "File": base64 encoded string,
                    "FileType": string
                },
                ...
            ]
}
```
    > If citizen doesn't exist it will return a 404 status code, if the licensePlate data is not valid (it is vaid if it's a number between 5 and 7, it only contains upper case letters and numbers, and it does exists) it will return a Bad Request 400 status code, and if it returns a 500 server error there was an exception (server error, database error, etc).

3. POST / -> `"/ciudadanos"`:
    - This will take an object from the request.body, it must have the following format:
        - Your must send the data this way:
```json
{
    "licensePlate": string,
    "vehicleType": string,
    "vehicleColor": string,
    "address": string,
    "lat": string,
    "lon": string,
    "photos": [
        {
            "file": base64 encoded string,
            "fileType": string
        },
        {
            "file": base64 encoded string,
            "fileType": string
        },
        ...
    ]
}
```

    #### CAUTION!
    > When you are sending a base64 encoded string please put all the characters previus the first comma in the `fileType` property.

    > Example: `data:image/gif;base64,R0lGODlhAQABAAAAACw=`
    > Add to fileType: `data:image/gif;base64,`
    > Add to file: `R0lGODlhAQABAAAAACw=`
    > Or the request will be rejected by the server if you leave the info before the comma in the file property.

4. PUT / -> `"/ciudadanos"`:
    - You must add the full object to the body, and it will find it with the licensePlate
    if it exists, it will update it with the information uploaded, if not, it will show an error.

5. DELETE / -> `"/ciudadanos/{licensePlate}"`:
    - This will take the licensePlate from the endpoint, and if it exists, it will delete it,
    if not, it will show an error message.

6. PUT / -> `"/ciudadanos/updateStatus"`:
    - This endpoint is for updating the status of the citizen, you must send a json object with this format:
    ```json
    {
        "LicensePlate": string,
        "Status": string, // Only: "Reportado", "Incautado por grúa", "Retenido", "Liberado"
    }
    ```

### Endpoints for Users:

Format for Agents and Admins:
```json
{
    "GovernmentID": string,
    "Password": string
}
```

#### User CRUD:

- GET / -> `"/users"`: Returns a list of agents.
- GET / -> `"/user/{governmentID}"`: Returns one agent with the following governmentID or 404 if not found.
- POST / -> `"/user"`: Receive a user through the request.body and saves it.
- PUT / -> `"/user/changePassword"`: Sets the password using the User from the request.body.
- DELETE / -> `"/user/{governmentID}"`: Deletes the user using the governmentID from the route.

#### Agents CRUD:

- GET / -> `"/agentes"`: Returns a list of agents.
- GET / -> `"/agente/{governmentID}"`: Returns one agent with the following governmentID or 404 if not found.
- POST / -> `"/agente"`: Receive a user through the request.body and saves it.
- PUT / -> `"/agente/changePassword"`: Sets the password using the User from the request.body.
- DELETE / -> `"/agente/{governmentID}"`: Deletes the user using the governmentID from the route.

#### Admins CRUD:

- GET / -> `"/admins"`: Returns a list of agents.
- GET / -> `"/admin/{governmentID}"`: Returns one agent with the following governmentID or 404 if not found.
- POST / -> `"/admin"`: Receive a user through the request.body and saves it.
- PUT / -> `"/admin/changePassword"`: Sets the password using the User from the request.body.
- DELETE / -> `"/admin/{governmentID}"`: Deletes the user using the governmentID from the route.