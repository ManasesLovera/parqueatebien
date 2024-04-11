# demo-orion-tek
Demo para la aplicacion que estamos haciendo de incautacion de vehiculos.

## Backend docs

### This backend contains the following routes:

1. GET / -> `"/ciudadanos/ciudadanos"`:
    - This will return an array of objects with the whole data with this format:
    ```json
        [
            {
                "licensePlate": string,
                "description": string,
                "lat": string,
                "lon": string,
                "file": base64 encoded string,
                "fileType": string
            },
        ...
        ]
    ```
2. GET / -> `"/ciudadanos/{licensePlate}"`:
    - This will return an object that matches with the licensePlate inserted into the route passed.
    ```json
    {
        "citizen": 
            {
                "licensePlate": string,
                "description": string,
                "lat": string,
                "lon": string,
                "file": base64 encoded string,
                "fileType": string
            },
        "message": string
    }
    ```
    > If citizen is `null`, there was an error, please check the `"message"` and the status code, if everything is correct the message will be empty and the object will be provided.
3. POST / -> `"/ciudadanos"`:
    - This will take an object from the request.body, it must have the following format:
        - Your must send the data this way:
        ```json
            {
                "licensePlate": string,
                "description": string,
                "lat": string,
                "lon": string,
                "file": base64 encoded string,
                "fileType": string
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