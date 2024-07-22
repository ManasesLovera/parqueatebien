using System.ComponentModel.DataAnnotations;

namespace backend.Models;
// Model for each vehicle a citizen has
public class CitizenVehicle
{
    [Key]
    public int Id { get; set; }
    [RegularExpression(@"^[0-9]{11}$")]
    public string? GovernmentId { get; set; }
    [RegularExpression(@"^[A-Z]{1,2}[0-9]{6}$")]
    public string? LicensePlate { get; set; }
    [RegularExpression(@"^[0-9]{9}$")]
    public string? RegistrationDocument { get; set; }
    public string? Model { get; set; }
    public string? Year { get; set; }
    public string? Color { get; set; }
    [AllowedValues("Nuevo","Aprobado","No aprobado")]
    public string? Status { get; set; }
    public Citizen? Citizen { get; set; }
}
