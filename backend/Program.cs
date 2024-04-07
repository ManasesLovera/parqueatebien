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

Citizens citizens = new Citizens();

app.MapGet("/", () => "Hello World! Try using the route '/ciudadanos'.");
app.MapGet("/ciudadanos", () => citizens.GetCitizens());
app.MapGet("/ciudadanos/{lisencePlate}", (HttpContext httpContext) => citizens.GetCitizen(httpContext));
app.MapPost("/ciudadanos", (HttpContext httpContext) => citizens.AddCitizen(httpContext));
app.MapPut("/ciudadanos", (HttpContext httpContext) => citizens.UpdateCitizen(httpContext));
app.MapDelete("/ciudadanos/{lisencePlate}", (HttpContext httpContext) => citizens.DeleteCitizen(httpContext));

app.Run(); 