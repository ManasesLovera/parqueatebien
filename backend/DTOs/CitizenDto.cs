using backend.Models;

namespace backend.DTOs;

public class CitizenDto
{
    public string? GovernmentId { get; set; }
    public string? Name { get; set; }
    public string? Lastname { get; set; }
    public string? Email { get; set; }
    public bool Status { get; set; } = false;
    public string? Password { get; set; }
    public List<CitizenVehicle>? Vehicles { get; set; }
}
