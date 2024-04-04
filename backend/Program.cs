using Services;
using db;

var db = new db.DbConnection();

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

app.MapGet("/", () => "Hello World!");
app.MapGet("/ciudadanos", () => ciudadanos.GetCiudadanos());
app.MapGet("/ciudadanos/{matricula}", (string matricula) => ciudadanos.GetCiudadano(matricula));
app.MapPost("/ciudadanos", (Ciudadano ciudadano) => ciudadanos.AddCiudadano(ciudadano));

app.Run();