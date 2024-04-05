using Services;

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

Ciudadanos ciudadanos = new Ciudadanos();

app.MapGet("/", () => "Hello World! Try using the route '/ciudadanos'.");
app.MapGet("/ciudadanos", () => ciudadanos.GetCiudadanos());
app.MapGet("/ciudadanos/{matricula}", (HttpContext httpConext) => ciudadanos.GetCiudadano(httpConext));
app.MapPost("/ciudadanos", (HttpContext httpConext) => ciudadanos.AddCiudadano(httpConext));
app.MapPut("/ciudadanos", (HttpContext httpConext) => ciudadanos.UpdateCiudadano(httpConext));
app.MapDelete("/ciudadanos/{matricula}", (HttpContext httpConext) => ciudadanos.DeleteCiudadano(httpConext));

app.Run();