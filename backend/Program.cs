using System.Text.Json;
using backend.Models;
using backend.DTOs;
using Newtonsoft.Json;
using System.Security.Claims;
using System.Text;
using System.IdentityModel.Tokens.Jwt;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Net.Http;
using backend.Services;
using backend.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using backend;
using AutoMapper;
using FluentValidation;
using backend.Validations;
using System.Text.RegularExpressions;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(
        policy =>
        {
            policy.WithOrigins("http://127.0.0.1:5501", "http://127.0.0.1:50775")
                  .AllowAnyOrigin()
                  .AllowAnyMethod()
                  .AllowAnyHeader();
        });
});

// Database connection EF
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlite(connectionString));

//Token Generator
builder.Services.AddScoped<TokenService>();

// Authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
        };
    });

// Authorization
builder.Services.AddAuthorization();

// AutoMapper
builder.Services.AddAutoMapper(typeof(MappingConfig));

// Validation
builder.Services.AddScoped<IValidator<ReportDto>, ReportDtoValidator>();
builder.Services.AddScoped<IValidator<UserDto>, UserDtoValidator>();
builder.Services.AddScoped<IValidator<CitizenDto>, CitizenDtoValidator>();
builder.Services.AddScoped<IValidator<CitizenVehicle>, CitizenVehicleValidator>();

var app = builder.Build();

// Aplicar migraciones y sembrar la base de datos al arrancar la aplicación
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<ApplicationDbContext>();
    db.Database.Migrate();
    ApplicationDbContext.Seed(db); // Llamada al Seed Method
}

// Middleware para captura de errores
app.Use(async (context, next) =>
{
    try
    {
        await next();
    }
    catch (Exception ex)
    {
        context.Response.StatusCode = 500;
        await context.Response.WriteAsJsonAsync(new { error = ex.Message });
    }
});

app.UseCors();
app.UseHttpsRedirection();
app.UseAuthentication();
app.UseAuthorization();

// Endpoints for citizens

app.MapGet("/", () =>
{
    return Results.Ok("Nothing available here");
});

app.MapGet("/api/reportes", async (IMapper _mapper, ApplicationDbContext context) =>
{
    try
    {
        var reportsQuery = context.Reports
        .Select(report => new
        {
            Report = report,
            Pictures = context.Pictures.Where(p => p.LicensePlate == report.LicensePlate).ToList()
        });

        var reportsData = await reportsQuery.ToListAsync();

        List<ReportResponseDto> reports = new List<ReportResponseDto>();
        foreach (var reportData in reportsData)
        {
            ReportResponseDto reportDto = _mapper.Map<ReportResponseDto>(reportData.Report);
            reportDto.Photos = _mapper.Map<List<PictureDto>>(reportData.Pictures);
            reports.Add(reportDto);
        }

        return Results.Ok(reports);
    }
    catch(Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
    
})
    .WithName("GetAllReports")
    .Produces<List<ReportResponseDto>>(200)
    .RequireAuthorization();

app.MapGet("/api/reporte/{licensePlate}", async (IMapper _mapper, ApplicationDbContext context,[FromRoute] string licensePlate) =>
{
    try
    {
        var reportData = await context.Reports
        .OrderByDescending(r => r.Id)
        .Where(r => r.LicensePlate == licensePlate)
        .Select(report => new
        {
            Report = report,
            Pictures = context.Pictures.Where(p => p.LicensePlate == report.LicensePlate).ToList()
        })
        .FirstOrDefaultAsync();

        if (reportData == null)
        {
            return Results.NotFound();
        }

        ReportResponseDto reportDto = _mapper.Map<ReportResponseDto>(reportData.Report);
        reportDto.Photos = _mapper.Map<List<PictureDto>>(reportData.Pictures);

        return Results.Ok(reportDto);
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .WithName("GetReport")
    .Produces<ReportResponseDto>(200);

app.MapPost("/api/reporte", async (
    IValidator<ReportDto> validator, IMapper _mapper,
    ApplicationDbContext context, [FromBody] ReportDto reportDto) =>
{
    try
    {
        var validationResult = await validator.ValidateAsync(reportDto);
        if (!validationResult.IsValid)
        {
            return Results.BadRequest(validationResult.Errors);
        }
        var existingReports = await context.Reports
            .Where(r => r.LicensePlate == reportDto.LicensePlate &&
                  ((r.Status != "Liberado" && r.Active) || !r.Active))
            .AnyAsync();

        if (existingReports)
        {
            return Results.Conflict("Ya existe un reporte activo para esta placa que no está liberado.");
        }
        var report = _mapper.Map<Report>(reportDto);
        report.ReportedDate = DateTime.Now.ToString("g");
        var lastReport = await context.Reports.OrderByDescending(r => r.Id).FirstOrDefaultAsync();
        int id = lastReport != null ? lastReport.Id + 1 : 1;
        report.RegistrationNumber = $"PB-{DateTime.Now.Year}-{DateTime.Now.Month}{DateTime.Now.Day}-{id}";
        var photos = _mapper.Map<List<Picture>>(reportDto.Photos);
        foreach (var photo in photos)
        {
            photo.LicensePlate = report.LicensePlate!;
            context.Pictures.Add(photo);
        }
        report.Photos = photos;
        context.Reports.Add(report);
        await context.SaveChangesAsync();
        return Results.Created("/api/report/" + reportDto.LicensePlate,
            _mapper.Map<ReportResponseDto>(context.Reports.FirstOrDefault(r => r.LicensePlate == report.LicensePlate)));
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapDelete("/api/reporte/{licensePlate}", async (ApplicationDbContext context, [FromRoute] string licensePlate) =>
{
    try
    {
        if (licensePlate == null || !Regex.IsMatch(licensePlate, @"^[A-Z]{1,2}[0-9]{6}$"))
        {
            return Results.BadRequest("La placa no es valida");
        }
        var report = await context.Reports.FirstOrDefaultAsync(r => r.LicensePlate == licensePlate);
        if (report == null)
        {
            return Results.NotFound();
        }
        var pictures = await context.Pictures.Where(p => p.LicensePlate == licensePlate).ToListAsync();
        context.Pictures.RemoveRange(pictures);
        context.Reports.Remove(report);
        await context.SaveChangesAsync();
        return Results.Ok();
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapPut("/api/reporte/actualizarEstado", async (ApplicationDbContext context, [FromBody] ChangeStatusDTO changeStatusDTO, ClaimsPrincipal user) =>
{
    try
    {
        if (!changeStatusDTO.Validate())
        {
            return Results.BadRequest("Esta informacion no es valida");
        }
        var report = context.Reports.Where(r => r.LicensePlate == changeStatusDTO.LicensePlate 
                                    && (r.Status != "Liberado" && r.Active))
                                    .ToList().FirstOrDefault();
        if(report == null)
        {
            return Results.NotFound();
        }
        else
        {
            if (changeStatusDTO.NewStatus == "Incautado por grua" && report.Status == "Reportado")
            {
                report.Status = changeStatusDTO.NewStatus;
                report.TowedByCraneDate = DateTime.Now.ToString("g");
            }

            else if (changeStatusDTO.NewStatus == "Retenido" && report.Status == "Incautado por grua")
            {
                report.Status = "Retenido";
                report.ArrivalAtParkinglot = DateTime.Now.ToString("g");
            }
            else if (changeStatusDTO.NewStatus == "Liberado" && report.Status == "Retenido")
            {
                report.Status = "Liberado";
                report.ReleasedBy = changeStatusDTO.Username;
                report.ReleaseDate = DateTime.Now.ToString("g");
            }
            else
            {
                return Results.Conflict("No puede ser modificado a ese estado");
            }
            await context.SaveChangesAsync();
            return Results.Ok("El estatus fue actualizado");
        }
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapGet("/api/reportes/estadisticas", (ApplicationDbContext context) =>
{
    int reportados = context.Reports.Where(r => r.Status == "Reportado").ToList().Count;
    int incautados = context.Reports.Where(r => r.Status == "Incautado por grua").ToList().Count;
    int retenidos = context.Reports.Where(r => r.Status == "Retenido").ToList().Count;
    int liberados = context.Reports.Where(r => r.Status == "Liberado").ToList().Count;

    return Results.Ok(new { reportados, incautados, retenidos, liberados });
})
    .RequireAuthorization();

// USUARIOS

app.MapPost("/api/user/register", async (IValidator<UserDto> validator, IMapper _mapper,
    UserDto userDto, ApplicationDbContext context) =>
{
    try
    {
        var validationResult = await validator.ValidateAsync(userDto);
        if (!validationResult.IsValid)
        {
            return Results.BadRequest(validationResult.Errors);
        }
        bool existUser = context.Users.FirstOrDefault(u => u.EmployeeCode == userDto.EmployeeCode || u.Username == userDto.Username)
                    != null ? true : false;

        if (existUser)
        {
            return Results.Conflict("Este usuario ya existe existe");
        }
        if (!String.IsNullOrEmpty(userDto.CraneCompany) && userDto.Role == "Grua")
        {
            var craneCompany = context.CraneCompanies.FirstOrDefault(c => c.CompanyName == userDto.CraneCompany);
            if (craneCompany == null)
            {
                return Results.Conflict("Compañia de grua no existe");
            }
            var user = _mapper.Map<User>(userDto);
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(userDto.Password);
            context.Users.Add(user);
            craneCompany.AmountCraneAgents += 1;
            await context.SaveChangesAsync();
            return Results.Created("/api/user/" + user.EmployeeCode, user);
        }
        else if ((userDto.Role == "Admin" || userDto.Role == "Agente") && String.IsNullOrEmpty(userDto.CraneCompany))
        {
            var user = _mapper.Map<User>(userDto);
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(userDto.Password);
            context.Users.Add(user);
            await context.SaveChangesAsync();

            return Results.Ok(new { Message = "User registered successfully" });
        }
        else
        {
            return Results.BadRequest("Rol no es valido");
        }
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
    
});

app.MapPost("/api/user/login", ([FromBody] UserLoginDto userDto, ApplicationDbContext context, TokenService tokenService) =>
{
    try
    {
        if(userDto.Role == "Grua" || userDto.Role == "Admin" || userDto.Role == "Agente")
        {
            var user = context.Users.FirstOrDefault(u => u.Username == userDto.Username
                                                    && u.Role == userDto.Role);

            if (user == null || !BCrypt.Net.BCrypt.Verify(userDto.Password, user!.PasswordHash))
            {
                return Results.Conflict(new { Message = "Usuario y/o contraseña incorrectos" });
            }
            var token = tokenService.GenerateToken(user);
            return Results.Ok(token);
        }
        else
        {
            return Results.BadRequest(new { Message = "Rol no existe." });
        }
    }
    catch(Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
});

app.MapGet("/api/users", (IMapper _mapper, ApplicationDbContext context) => 
{ 
    try
    {
        var users = _mapper.Map<List<UserResponseDto>>(context.Users.ToList());
        return Results.Ok(users);
    }
    catch(Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapGet("api/user/{username}", ([FromRoute] string username, ApplicationDbContext context) =>
{
    try
    {
        var user = context.Users.FirstOrDefault(u => u.Username == username);
        if (user == null)
        {
            return Results.NotFound();
        }
        return Results.Ok(user);
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapPut("/api/user/changePassword", async ([FromBody] ChangePasswordDto CPDto, ApplicationDbContext context) =>
{
    try
    {
        var user = context.Users.FirstOrDefault(u => u.Username == CPDto.Username);
        if(user == null)
        {
            return Results.NotFound();
        }
        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(CPDto.Password);
        await context.SaveChangesAsync();
        return Results.Ok();
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapDelete("/api/user/{username}", async ([FromRoute] string username, ApplicationDbContext context) =>
{
    try
    {
        var user = context.Users.FirstOrDefault(u => u.Username == username);
        if(user == null)
        {
            return Results.NotFound();
        }
        context.Users.Remove(user);
        await context.SaveChangesAsync();
        return Results.Ok(new { Message = "Se borro correctamente"} );
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

// CIUDADANOS

// GET ALL CITIZENS ENDPOINT

app.MapPost("/api/citizen/register", ([FromBody] CitizenDto citizenDto, ApplicationDbContext context,
    IValidator<CitizenDto> validatorCitizen, IValidator<CitizenVehicle> validatorCitizenVehicle, IMapper _mapper) =>
{
    try
    {
        var validationResult = validatorCitizen.Validate(citizenDto);
        if (!validationResult.IsValid)
        {
            return Results.BadRequest(validationResult.Errors);
        }
        foreach (var citizenVehicle in citizenDto.Vehicles!)
        {
            var validation = validatorCitizenVehicle.Validate(citizenVehicle);
            if (!validation.IsValid)
                return Results.BadRequest(validation.Errors);
            
        }
        var citizen = context.Citizens.FirstOrDefault(c => c.GovernmentId == citizenDto.GovernmentId);
        if (citizen != null)
        {
            return Results.Conflict(new { Message = "Este ciudadano ya existe" });
        }
        return Results.Ok();
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapPost("/api/citizen/login", ([FromBody] CitizenLoginDto user, ApplicationDbContext context, TokenService tokenService) =>
{
    try
    {
        var citizen = context.Citizens.FirstOrDefault(c => c.GovernmentId == user.GovernmentId);
        if (citizen == null || BCrypt.Net.BCrypt.Verify(user.Password, citizen.PasswordHash))
        {
            return Results.Conflict(new { Message = "Cedula y/o contraseña incorrectos" });
        }
        var token = tokenService.GenerateToken(user);
        return Results.Ok(token);
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapDelete("/api/citizen/{governmentId}", async (ApplicationDbContext context, [FromRoute] string governmentId) => 
{
    try
    {
        governmentId = governmentId.Replace("-", "");

        if (Regex.IsMatch(governmentId, @"^[0-9]{11}$"))
            return Results.BadRequest("La cedula no es valida");

        var citizen = context.Citizens.FirstOrDefault(c => c.GovernmentId == governmentId);

        if (citizen == null)
            return Results.NotFound();

        var citizenVehicles = citizen.Vehicles;
        context.CitizenVehicles.RemoveRange(citizenVehicles!);
        context.Citizens.Remove(citizen);
        await context.SaveChangesAsync();
        return Results.Ok();
    }
    catch(Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

// UPDATE STATUS CITIZEN ENDPOINT

// Crane company

app.MapGet("/api/craneCompanies/", (ApplicationDbContext context) =>
{
    try
    {
        var craneCompanies = context.CraneCompanies.ToList();
        return Results.Ok(craneCompanies);
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapGet("/api/craneCompany/{rnc}", (ApplicationDbContext context, [FromRoute] string rnc) =>
{
    try
    {
        var craneCompany = context.CraneCompanies.FirstOrDefault(c => c.RNC == rnc);
        return craneCompany == null ?
        Results.NotFound() : 
        Results.Ok(craneCompany);
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapPost("/api/craneCompany/", async ([FromBody] CraneCompany craneCompany, ApplicationDbContext context) =>
{
    try
    {
        var exist = context.CraneCompanies.FirstOrDefault(c => c.RNC == craneCompany.RNC);
        if (exist != null)
            return Results.Conflict(new {Message = "ya existe"});
        if(String.IsNullOrEmpty(craneCompany.RNC) || String.IsNullOrEmpty(craneCompany.CompanyName) || String.IsNullOrEmpty(craneCompany.PhoneNumber))
        {
            return Results.BadRequest("Se debe recibir RNC, CompanyName y PhoneNumber");
        }
        craneCompany.AmountCraneAgents = 0;
        context.CraneCompanies.Add(craneCompany);
        await context.SaveChangesAsync();
        return Results.Ok(new { Message = "Se agrego correctamente" } );
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.MapDelete("/api/craneCompany/{rnc}", async (ApplicationDbContext context, [FromRoute] string rnc) =>
{
    try
    {
        var craneCompany = context.CraneCompanies.FirstOrDefault(c => c.RNC == rnc);

        if (craneCompany == null)
            return Results.NotFound();

        context.CraneCompanies.Remove(craneCompany);
        await context.SaveChangesAsync();
        return Results.Ok();
    }
    catch (Exception ex)
    {
        return Results.Problem(ex.Message, statusCode: 500);
    }
})
    .RequireAuthorization();

app.Run();