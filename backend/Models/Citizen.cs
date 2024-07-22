using System.ComponentModel.DataAnnotations;
using backend.Interfaces;

namespace backend.Models;
// Model for Citizen
public class Citizen : IUser
{
    [Key]
    public int Id { get; set; }
    [RegularExpression(@"^[0-9]{11}$")]
    public string? GovernmentId { get; set; }
    public string? Name {  get; set; }
    public string? Lastname { get; set; }
    public string? Email { get; set; }
    [AllowedValues("Nuevo", "Aprobado", "No aprobado")]
    public string? Status { get; set; }
    public string? PasswordHash { get; set; }
    public List<CitizenVehicle>? Vehicles { get; set; }
    public string? NotificationToken { get; set; }
}
