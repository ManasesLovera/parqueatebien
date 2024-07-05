namespace backend.DTOs;

public class ReportResponseDto
{
    public string? RegistrationNumber { get; set; }
    public string? LicensePlate { get; set; }
    public string? RegistrationDocument { get; set; }
    public string? VehicleType { get; set; }
    public string? VehicleColor { get; set; }
    public string? Model { get; set; }
    public string? Year { get; set; }
    public string? Reference { get; set; }
    public string? Status { get; set; }
    public bool Active { get; set; }
    public string? ReportedBy { get; set; }
    public string? ReportedDate { get; set; }
    public string? TowedByCraneDate { get; set; }
    public string? ArrivalAtParkinglot { get; set; }
    public string? ReleaseDate { get; set; }
    public string? ReleasedBy { get; set; }
    public string? Lat { get; set; }
    public string? Lon { get; set; }
    public List<PictureDto> Photos { get; set; } = new List<PictureDto>();
}
