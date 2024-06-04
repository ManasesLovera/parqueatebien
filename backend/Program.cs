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

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(
        policy =>
        {
            policy.WithOrigins("http://127.0.0.1:5501", "http://127.0.0.1:50775")
                  .AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

var app = builder.Build();
app.UseCors();

CitizensService citizens = new CitizensService();
UsersCRUD users = new UsersCRUD();

// Endpoints for citizens

app.MapGet("/", async (HttpContext context) =>
{
    await context.Response.WriteAsync("Nothing available here");
});

app.MapGet("/ciudadanos/ciudadanos", () => DbConnection.GetAllCitizens());

app.MapGet("/ciudadanos/{licensePlate}", async (HttpContext context, [FromRoute] string licensePlate) =>
{
    try
    {
        var Validation = citizens.ValidateCitizenRequest(licensePlate);
        if (Validation.Result == null)
        {
            context.Response.StatusCode = 400;
            await context.Response.WriteAsJsonAsync(Validation.ErrorMessages);
        }
        Citizen? citizen = DbConnection.GetByLicensePlate(Validation.Result!);
        if (citizen == null)
        {
            context.Response.StatusCode = 404;
        }
        else
        {
            string citizenJson = System.Text.Json.JsonSerializer.Serialize(citizen);
            context.Response.StatusCode = 200;
            await context.Response.WriteAsync(citizenJson);
        }
    }
    catch (Exception ex)
    {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsync(ex.Message);
    }
});

app.MapPost("/ciudadanos", async (HttpContext httpContext, [FromBody] CitizenRequest citizen) =>
{
    Console.WriteLine(citizen);
    try
    {
        if (citizen == null || !citizens.ValidateCitizenBody(citizen))
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (DbConnection.GetByLicensePlate(citizen!.LicensePlate) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: This licensePlate already exists");
        }
        else
        {
            DbConnection.AddCitizen(citizen);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Citizen added successfully!");
        }

    }
    catch (Exception ex)
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

        }
        if (DbConnection.GetByLicensePlate(citizen!.LicensePlate) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");

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
            string responseMessage = DbConnection.DeleteCitizen(licensePlate);
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

app.MapPut("/ciudadanos/updateStatus", async (HttpContext httpContext, [FromBody] ChangeStatusDTO changeStatusDTO) =>
{
    try
    {
        if (!changeStatusDTO.Validate())
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsJsonAsync("Esta informacion no es valida");
            return;
        }
        if (DbConnection.GetByLicensePlate(changeStatusDTO.LicensePlate) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("No se encontro vehiculo con esta matricula");
            return;
        }
        else
        {
            var user = DbConnection.GetByLicensePlate(changeStatusDTO.LicensePlate);
            if (changeStatusDTO.NewStatus == "Incautado por grua" && user!.Status == "Reportado")
                DbConnection.SetDateTime(changeStatusDTO.LicensePlate, "TowedByCraneDate", "Incautado");

            else if (changeStatusDTO.NewStatus == "Retenido" && user!.Status == "Incautado por grua")
                DbConnection.SetDateTime(changeStatusDTO.LicensePlate, "ArrivalAtParkinglot", "Retenido");

            else if (changeStatusDTO.NewStatus == "Liberado" && user!.Status == "Retenido")
                DbConnection.SetDateTime(changeStatusDTO.LicensePlate, "ReleaseDate", "Liberado");

            else
            {
                httpContext.Response.StatusCode = 409;
                await httpContext.Response.WriteAsync("409 Conflict - No puede ser modificado a ese estado");
                return;
            }
            DbConnection.UpdateCitizenStatus(changeStatusDTO);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("El estatus fue actualizado");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapGet("/ciudadanos/estadisticas", () => citizens.VehicleStatus());

// Endpoints for users

app.MapPost("users/login/{role}", async (HttpContext httpContext, [FromBody] User user, [FromRoute] string role) =>
{
    try
    {
        if ((user == null || user.GovernmentID == null || user.Password == null || user.Role == null) && citizens.ValidateRole(user!.Role))
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (users.IsValid(user.GovernmentID!, user.Password!))
        {
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("OK");
        }
        else if (users.GetByGovernmentIDWithRole(user.GovernmentID!, role) != null)
        {
            httpContext.Response.StatusCode = 401;
            await httpContext.Response.WriteAsync("Unathorized - Wrong Password");
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

app.MapGet("/users", () =>
    users.GetAll());

app.MapGet("/users/{role}", ([FromBody] string role) =>
users.GetAllByRole(role));

app.MapGet("/user/{governmentID}", ([FromRoute] string governmentID) =>
    users.GetByGovernmentID(governmentID));

app.MapPost("/user", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if ((user == null || user.GovernmentID == null || user.Password == null || user.Role == null) && citizens.ValidateRole(user!.Role))
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Faltan datos o informacion invalida!");
        }
        else if (users.GetByGovernmentID(user!.GovernmentID!) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: Ya existe");
        }
        else
        {
            users.Add(user);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Usuario agregado!");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapPut("/users/changePassword", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Faltan datos o informacion invalida!");
        }
        if (users.GetByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("No se encontro!");
        }
        else
        {
            users.ChangePassword(user);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Actualizado!");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapDelete("/users/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        //if (governmentID.Trim().Length != 11)
        //{
        //    httpContext.Response.StatusCode = 400;
        //    await httpContext.Response.WriteAsync("La c�dula debe contener 11 caracteres");
        //}
        if (users.GetByGovernmentID(governmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("El usuario no existe");
        }
        else
        {
            users.Delete(governmentID!);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Se elimin� correctamente!");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.Run();