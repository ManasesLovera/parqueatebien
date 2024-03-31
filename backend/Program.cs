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
app.MapGet("/", () => "Hello World!");

app.Run();
