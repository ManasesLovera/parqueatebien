namespace backend.Models;
public class Report
{
    public int Id { get; set; }
    public string? RegistrationNumber { get; set; }
    public string? LicensePlate { get; set; }
    public string? RegistrationDocument { get; set; }
    public string? VehicleType { get; set; }
    public string? VehicleColor { get; set; }
    public string? Model { get; set; }
    public string? Year { get; set; }
    public string? Reference { get; set; }
    public string Status { get; set; } = "Reportado";
    public bool Active { get; set; } = true;
    public string? ReportedBy { get; set; }
    public string? ReportedDate { get; set;}
    public string? TowedByCraneDate {  get; set; } = null;
    public string? ArrivalAtParkinglot { get; set; } = null;
    public string? ReleaseDate { get; set; } = null;
    public string? ReleasedBy { get; set; } = null;
    public string? Lat { get; set; }
    public string? Lon { get; set; }
}