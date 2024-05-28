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
            policy.SetIsOriginAllowed(origin => new Uri(origin).IsLoopback);
        });
});

var app = builder.Build();
app.UseCors();

CitizensService citizens = new();

// Endpoints for citizens

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

app.MapGet("/login", async (HttpContext httpContext, [FromBody] User User) =>
{
    try
    {
        if (User.GovernmentID == null || User.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }

        if (DbConnection.IsValidAgent(User.GovernmentID!, User.Password!))
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

app.MapGet("/agentes", () => 
    DbConnection.GetAllAgents());

app.MapGet("/agente/{governmentID}", ([FromRoute] string governmentID) => 
    DbConnection.GetAgentByGovernmentID(governmentID));

app.MapPost("/agente", async (HttpContext httpContext, [FromBody] User user) =>
{
    try
    {
        if (user == null || user.GovernmentID == null || user.Password == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
        }
        if (DbConnection.GetAgentByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: The governmentID already exists");
        }
        else
        {
            DbConnection.AddAgent(user);
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
        if (DbConnection.GetAgentByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Not Found");
        }
        else
        {
            DbConnection.ChangeAgentPassword(user);
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
        if (DbConnection.GetAgentByGovernmentID(governmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("User was not found");
        }
        else
        {
            DbConnection.DeleteAgent(governmentID!);
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

app.MapGet("/admins", () => DbConnection.GetAllAdmins());

app.MapGet("/admin/{governmentID}", async (HttpContext httpContext, [FromRoute] string governmentID) =>
{
    try
    {
        if (governmentID.Length != 11)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("La cédula debe contener 11 caracteres");
        }
        if (DbConnection.GetAgentByGovernmentID(governmentID) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("No se encontro el admin");
        }
        else
        {
            User user = DbConnection.GetAdminByGovernmentID(governmentID)!;
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
        if (DbConnection.GetAdminByGovernmentID(user!.GovernmentID!) == null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: The governmentID already exists");
        }
        else
        {
            DbConnection.AddAdmin(user);
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
        if (DbConnection.GetAdminByGovernmentID(governmentID!) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("User was not found");
        }
        else
        {
            DbConnection.DeleteAdmin(governmentID!);
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