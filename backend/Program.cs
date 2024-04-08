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

CitizensService citizens = new CitizensService();

app.MapGet("/", () => "Hello World! Try using the route '/ciudadanos'.");
app.MapGet("/ciudadanos", () => citizens.GetCitizens());
app.MapGet("/ciudadanos/{licensePlate}", (HttpContext httpContext) => citizens.GetCitizen(httpContext));
app.MapPost("/ciudadanos", (HttpContext httpContext) => citizens.AddCitizen(httpContext));
app.MapPut("/ciudadanos", (HttpContext httpContext) => citizens.UpdateCitizen(httpContext));
app.MapDelete("/ciudadanos/{licensePlate}", (HttpContext httpContext) => citizens.DeleteCitizen(httpContext));

app.Run(); 