using Services;
using System.Text.Json;
using Models;
using Newtonsoft.Json;
using System.Security.Claims;
using System.Text;
using db;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Net.Http;

// Agregar direccion de incautar autos, y color del vehiculo DONE
// Modificar usuarios, debe agregar cedula y contraseña DONE
// Estado del vehiculo si fue incautado o si esta en el parqueadero
// CRUD de usuarios
// Para la demo no se necesita hash o encriptacion para las password
// validar con listas
// multiples fotos MISSING

// Debe contener roles de usuario -> BackOffice, Agente

// MODIFICA EL README FILE

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(
        policy =>
        {
            policy.SetIsOriginAllowed(origin => new Uri(origin).IsLoopback);
        });
});

var app = builder.Build();
app.UseCors();

CitizensService citizens = new();

app.MapGet("/", async (HttpContext context) =>
{
    await context.Response.WriteAsync("Nothing available here");
});

app.MapGet("/ciudadanos", () => DbConnection.GetAllCitizens());

app.MapGet("/ciudadanos/{licensePlate}", async (HttpContext context, [FromRoute] string licensePlate) =>
{
    try
    {
        var Validation = citizens.ValidateCitizenRequest(licensePlate);
        if (Validation.Result == null)
        {
            context.Response.StatusCode = 400;
            await context.Response.WriteAsJsonAsync(Validation.ErrorMessages);
            return;
        }

        Citizen? citizen = DbConnection.GetByLicensePlate(Validation.Result);
        if (citizen == null)
        {
            context.Response.StatusCode = 404;
            return;
        }

        string citizenJson = System.Text.Json.JsonSerializer.Serialize(citizen);
        context.Response.StatusCode = 200;
        await context.Response.WriteAsync(citizenJson);
    }
    catch (Exception ex)
    {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsync(ex.Message);
    }

});

app.MapPost("/ciudadanos", async (HttpContext httpContext, [FromBody] Citizen citizen) =>
{
    try
    {
        if (citizen == null || !citizens.ValidateCitizenBody(citizen))
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if(DbConnection.GetByLicensePlate(citizen!.LicensePlate) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: This licensePlate already exists");
        }
        else
        {
            citizens.AddCitizen(citizen);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Citizen added successfully!");
        }
        
    }
    catch(Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapPut("/ciudadanos", async (HttpContext httpContext, [FromBody] Citizen citizen) =>
{
    try
    {
        if (citizen == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
            return;
        }
        if (DbConnection.GetByLicensePlate(citizen!.LicensePlate) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");
            return;
        }
        citizens.UpdateCitizen(citizen);
        httpContext.Response.StatusCode = 200;
        await httpContext.Response.WriteAsync("Updated successfully");
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapDelete("/ciudadanos/{licensePlate}", async (HttpContext httpContext, [FromRoute] string licensePlate) =>
{
    try
    {
        var validation = citizens.ValidateCitizenRequest(licensePlate);
        if (validation.Result == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsJsonAsync(validation.ErrorMessages);
        }
        if (DbConnection.GetByLicensePlate(validation.Result!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Citizen was not found");
        }
        else
        {
            string responseMessage = DbConnection.DeleteCitizen(validation.Result!);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync(responseMessage);
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapPut("/ciudadanos/updateStatus/{licensePlate}", async (HttpContext httpContext, [FromRoute] string licensePlate) =>
{
    try
    {
        var validation = citizens.ValidateCitizenRequest(licensePlate);
        if (validation.Result == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsJsonAsync(validation.ErrorMessages);
        }
        if (DbConnection.GetByLicensePlate(validation.Result!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Citizen was not found");
        }
        else
        {
            DbConnection.UpdateCitizenStatusToParqueadero(validation.Result!);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Status Updated successfully");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapGet("/login", async (HttpContext httpContext, [FromBody] User User) =>
{
    try
    {
        if (User.GovernmentID == null || User.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }

        if (DbConnection.IsValidUser(User.GovernmentID!, User.Password!))
        {
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("OK");
        }
        else
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapGet("/usuarios", () => 
    DbConnection.GetAllUsers());

app.MapGet("/usuario/{governmentID}", ([FromRoute] string governmentID) => 
    DbConnection.GetUserByGovernmentID(governmentID));

app.MapPost("/usuario", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (DbConnection.GetUserByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: The governmentID already exists");
        }
        else
        {
            DbConnection.AddUser(user);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("User added successfully!");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapPut("/usuario/changePassword", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (DbConnection.GetUserByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");
        }
        else
        {
            DbConnection.ChangeUserPassword(user);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Updated successfully");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapDelete("/usuario/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        if (governmentID == null)
        {
            httpContext.Response.StatusCode = 400;
            return;
        }
        if (DbConnection.GetUserByGovernmentID(governmentID) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("User was not found");
            return;
        }
        DbConnection.DeleteUser(governmentID);
        httpContext.Response.StatusCode = 200;
        await httpContext.Response.WriteAsync("Deleted successfully");
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.Run();