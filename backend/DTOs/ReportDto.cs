using backend.Models;

namespace backend.DTOs;

public class ReportDto
{
    public string? LicensePlate { get; set; }
    public string? RegistrationDocument { get; set; }
    public string? VehicleType { get; set; }
    public string? VehicleColor { get; set; }
    public string? Model { get; set; }
    public string? Year { get; set; }
    public string? Reference { get; set; }
    public string? Lat { get; set; }
    public string? Lon { get; set; }
    public string? ReportedBy { get; set; }
    public List<PictureDto>? Photos { get; set; }
}