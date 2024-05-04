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

CitizensService citizens = new CitizensService();

app.MapGet("/ciudadanos/ciudadanos", () => citizens.GetCitizens());
// agregar validacion y mandar bad request si el string no es valido
// hacer un try catch y el try mande un valor valido o un 404 si la funcion manda null
// si es catch manda un 500
app.MapGet("/ciudadanos/{licensePlate}", async (HttpContext context) =>
{
    try
    {
        string? licensePlate = citizens.ValidateGetCitizenRequest(context);
        if (licensePlate == null)
        {
            context.Response.StatusCode = 400;
            await context.Response.WriteAsync("La matricula insertada no es valida");
            return;
        }
        Citizen? citizen = citizens.GetCitizen(licensePlate);
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