using backend.Models;
using Microsoft.EntityFrameworkCore;

namespace backend.Data;
public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }
    public DbSet<User> Users { get; set; }
    public DbSet<Report> Reports { get; set; }
    public DbSet<Picture> Pictures { get; set; }
    public DbSet<Citizen> Citizens { get; set; }
    public DbSet<CitizenVehicle> Vehicles { get; set; }
    public DbSet<CraneCompany> CraneCompanies { get; set; }
    public static void Seed(ApplicationDbContext context)
    {
        if (!context.CraneCompanies.Any())
        {
            context.CraneCompanies.AddRange(
                new CraneCompany
                {
                    RNC = "123456789",
                    CompanyName = "Servicio de grua",
                    PhoneNumber = "8095441234"
                },
                new CraneCompany
                {
                    RNC = "234567890",
                    CompanyName = "Servicio de grua 2",
                    PhoneNumber = "8095442345"
                }
            );
        }
        if (!context.Users.Any())
        {
            context.Users.AddRange(
                new User
                {
                    EmployeeCode = "001",
                    Name = "Admin",
                    Lastname = "Admin",
                    Username = "admin",
                    PasswordHash = BCrypt.Net.BCrypt.HashPassword("123"),
                    Status = true,
                    Role = "Admin"
                }
            );
        }
    }
}
