# demo-orion-tek
Demo para la aplicacion que estamos haciendo de incautacion de vehiculos.

## Backend docs

### This backend contains the following routes:

1. GET / -> `"/ciudadanos"`:
    - This will return an array of objects with the whole data with this format:
    ```json
        [
            {
            "Photo": string,
            "Location": {
                "Lat": string,
                "Lon": string
            },
            "LicensePlate": string
            },
        ...
        ]
        ```
2. GET / -> `"/ciudadanos/{licensePlate}"`:
    - This will return an object that matches with the licensePlate inserted into the route passed.
    ```json
    {
        "citizen": Citizen,
        "message": string
    }
    ```
    > If citizen is `null`, there was a mistake, please check the `"message"`, if everything is correct the message will be empty.
3. POST / -> `"/ciudadanos"`:
    - This will take an object from the request.body, it must have the following format:
        - Your must send the data this way:
        ```json
            {
            "Photo": string,
            "Location": {
                "Lat": string,
                "Lon": string
            },
            "LicensePlate": string
            }
        ```

    #### CAUTION!
    > When you are sending a base64 encoded string please remove all the characters previus the first comma.

    > Example: `data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAQMAAAD+wSzIAAAABlBMVEX///+/v7+jQ3Y5AAAADklEQVQI12P4AIX8EAgALgAD/aNpbtEAAAAASUVORK5CYII`
    > REMOVE: `data:image/png;base64,`
    > And send: `iVBORw0KGgoAAAANSUhEUgAAAAgAAAAIAQMAAAD+wSzIAAAABlBMVEX///+/v7+jQ3Y5AAAADklEQVQI12P4AIX8EAgALgAD/aNpbtEAAAAASUVORK5CYII`
    > Or the request will be rejected by the server.

4. PUT / -> `"/ciudadanos"`:
    - You must add the full object to the body, and it will find it with the licensePlate
    if it exists, it will update it with the information uploaded, if not, it will show an error.

5. DELETE / -> `"/ciudadanos/{licensePlate}"`:
    - This will take the licensePlate from the endpoint, and if it exists, it will delete it,
    if not, it will show an error message.