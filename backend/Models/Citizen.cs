using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class Citizen : IUser
{
    [Key]
    public int Id { get; set; }
    [Required]
    [RegularExpression(@"^[0-9]{11}$")]
    public string? GovernmentId { get; set; }
    [Required]
    public string? Name {  get; set; }
    [Required]
    public string? Lastname { get; set; }
    [Required]
    [EmailAddress]
    public string? Email { get; set; }
    [Required]
    [AllowedValues("Nuevo", "Aprobado", "No aprobado")]
    public string? Status { get; set; }
    public string? PasswordHash { get; set; }
    public List<CitizenVehicle>? Vehicles { get; set; }
}
