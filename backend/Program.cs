using Services;
using System.Text.Json;

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

app.MapGet("/ciudadanos", () => citizens.GetCitizens());
app.MapGet("/ciudadanos/{licensePlate}", async (HttpContext context) =>
{
    try
    {
        var Validation = citizens.ValidateGetCitizenRequest(context);
        if (Validation.Result == null)
        {
            context.Response.StatusCode = 400;
            await context.Response.WriteAsJsonAsync(Validation.ErrorMessages);
            return;
        }

        Citizen? citizen = citizens.GetCitizen(Validation.Result);
        if (citizen == null)
        {
            context.Response.StatusCode = 404;
            return;
        }

        string citizenJson = JsonSerializer.Serialize(citizen);
        context.Response.StatusCode = 200;
        await context.Response.WriteAsync(citizenJson);
    }
    catch (Exception ex)
    {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsync(ex.Message);
    }

});
app.MapPost("/ciudadanos", async (HttpContext httpContext) =>
{
    try
    {
        StreamReader reader = new StreamReader(httpContext.Request.Body);
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();
        Citizen? citizen = citizens.ValidatePostCitizenBody(body);

        if (citizen == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsync("Missing info or Invalid data");
            return;
        }
        if(citizens.GetCitizen(citizen!.LicensePlate) != null)
        {
            httpContext.Response.StatusCode = 409;
            await httpContext.Response.WriteAsync("409 Conflict: This licensePlate already exists");
            return;
        }
        citizens.AddCitizen(citizen);
        httpContext.Response.StatusCode = 200;
        await httpContext.Response.WriteAsync("Citizen added successfully!");
    }
    catch(Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});
app.MapPut("/ciudadanos", (HttpContext httpContext) => citizens.UpdateCitizen(httpContext));
app.MapDelete("/ciudadanos/{licensePlate}", async (HttpContext httpContext) =>
{
    try
    {
        var validation = citizens.ValidateGetCitizenRequest(httpContext);
        if (validation.Result == null)
        {
            httpContext.Response.StatusCode = 400;
            await httpContext.Response.WriteAsJsonAsync(validation.ErrorMessages);
            return;
        }
        if (citizens.GetCitizen(validation.Result) == null)
        {
            httpContext.Response.StatusCode = 404;
            await httpContext.Response.WriteAsync("Citizen was not found");
            return;
        }
        citizens.DeleteCitizen(validation.Result);
        httpContext.Response.StatusCode = 200;
        await httpContext.Response.WriteAsync("Deleted Successfully!");

    }
    catch (Exception ex)
    {
        httpContext.Response.StatusCode = 500;
        await httpContext.Response.WriteAsync(ex.Message);
    }
});

app.Run();