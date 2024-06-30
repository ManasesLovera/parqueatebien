# Backend Docs

## Endpoints

### Reportes

1. GET / -> `"/api/reportes"`:
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
2. GET / -> `"/api/reporte/{licensePlate}"`:
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
3. POST / -> `"/api/reporte"`:
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
4. DELETE / -> `"/api/reporte/{licensePlate}"`:
    - Delete the last report with the licensePlate in the route.
    - 200 OK, 404 NotFound, 400 BadRequest (Invalid LicensePlate)

5. PUT / -> `"/api/reporte/actualizarEstado"`:
    - Update the status of the report ['Reportado', 'Incautado por grua', 'Retenido', 'Liberado']
    - 200 Ok, 404 NotFound, 409 Conflict (can't be modified to the especified status)
```json
{
    "licensePlate": string,
    "newStatus": string,
    "username": string
}
```