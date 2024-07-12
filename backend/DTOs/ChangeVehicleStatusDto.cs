using System.ComponentModel.DataAnnotations;

namespace backend.DTOs;

public class ChangeVehicleStatusDto
{
    [Required]
    [RegularExpression(@"^[A-Z]{1,2}[0-9]{6}$")]
    public string? LicensePlate { get; set; }
    [Required]
    [AllowedValues("Aprobado", "No aprobado")]
    public string? Status { get; set; }
}
