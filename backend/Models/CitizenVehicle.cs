using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class CitizenVehicle
{
    [Key]
    public int Id { get; set; }
    [Required]
    [RegularExpression(@"^[0-9]{11}$")]
    public string? GovernmentId { get; set; }
    [Required]
    [RegularExpression(@"^[A-Z]{1,2}[0-9]{6}$")]
    public string? LicensePlate { get; set; }
    [Required]
    [RegularExpression(@"^[0-9]{9}$")]
    public string? RegistrationDocument { get; set; }
    [Required]
    public string? Model { get; set; }
    [Required]
    public string? Year { get; set; }
    [Required]
    public string? Color { get; set; }
    [AllowedValues("Nuevo","Aprobado","No aprobado")]
    public string? Status { get; set; }
}
