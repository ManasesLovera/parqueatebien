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
    public DbSet<CitizenVehicle> CitizenVehicles { get; set; }
    public DbSet<CraneCompany> CraneCompanies { get; set; }
}
