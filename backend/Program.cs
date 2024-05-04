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

app.MapGet("/ciudadanos/", () => citizens.GetCitizens());
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
app.MapPost("/ciudadanos", (HttpContext httpContext) => citizens.AddCitizen(httpContext));
app.MapPut("/ciudadanos", (HttpContext httpContext) => citizens.UpdateCitizen(httpContext));
app.MapDelete("/ciudadanos/{licensePlate}", (HttpContext httpContext) => citizens.DeleteCitizen(httpContext));

app.Run();