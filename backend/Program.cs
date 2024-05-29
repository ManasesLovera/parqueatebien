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
            policy//.WithOrigins("http://127.0.0.1:5501")
                  .AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

var app = builder.Build();
app.UseCors();

CitizensService citizens = new();
UsersCRUD agents = new UsersCRUD("Agents");
UsersCRUD admins = new UsersCRUD("Admins");

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
            DbConnection.AddCitizen(citizen);
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
            await httpContext.Response.WriteAsJsonAsync("Missing information or invalid data");
        }
        if (DbConnection.GetByLicensePlate(changeStatusDTO.LicensePlate) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Citizen was not found");
        }
        else
        {
            DbConnection.UpdateCitizenStatus(changeStatusDTO);
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

// Endpoints for agents

app.MapPost("agente/login", async (HttpContext httpContext, [FromBody] User User) =>
{
    try
    {
        if (User.GovernmentID == null || User.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (agents.IsValid(User.GovernmentID!, User.Password!))
        {
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("OK");
        }
        else if (agents.GetByGovernmentID(User.GovernmentID!) != null)
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

app.MapGet("/agentes", () => 
    agents.GetAll());

app.MapGet("/agente/{governmentID}", ([FromRoute] string governmentID) => 
    agents.GetByGovernmentID(governmentID));

app.MapPost("/agente", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (agents.GetByGovernmentID(user!.GovernmentID!) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: The governmentID already exists");
        }
        else
        {
            agents.Add(user);
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

app.MapPut("/agente/changePassword", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (agents.GetByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");
        }
        else
        {
            agents.ChangePassword(user);
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

app.MapDelete("/agente/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        if (governmentID.Length != 11)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("La cédula debe contener 11 caracteres");
        }
        if (agents.GetByGovernmentID(governmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("User was not found");
        }
        else
        {
            agents.Delete(governmentID!);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Deleted successfully");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

// Endpoints for admins

app.MapPost("admin/login", async (HttpContext httpContext, [FromBody] User User) =>
{
    try
    {
        if (User.GovernmentID == null || User.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (admins.IsValid(User.GovernmentID!, User.Password!))
        {
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("OK");
        }
        else if (admins.GetByGovernmentID(User.GovernmentID!) != null)
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

app.MapGet("/admins", () => admins.GetAll());

app.MapGet("/admin/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        if (governmentID.Length != 11)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("La cédula debe contener 11 caracteres");
        }
        if (admins.GetByGovernmentID(governmentID) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("No se encontro el admin");
        }
        else
        {
            User user = admins.GetByGovernmentID(governmentID)!;
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsJsonAsync(user);
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.MapPost("/admin", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (admins.GetByGovernmentID(user!.GovernmentID!) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: The governmentID already exists");
        }
        else
        {
            admins.Add(user);
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

app.MapDelete("/admin/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        if (governmentID.Length != 11)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("La cédula debe contener 11 caracteres");
        }
        if (admins.GetByGovernmentID(governmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("User was not found");
        }
        else
        {
            admins.Delete(governmentID!);
            httpContext.Response.StatusCode = 200;
            await httpContext.Response.WriteAsync("Deleted successfully");
        }
    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.Run();