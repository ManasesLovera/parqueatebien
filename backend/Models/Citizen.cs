namespace backend.Models;

public class Citizen : IUser
{
    public int Id { get; set; }
    public string? GovernmentId { get; set; }
    public string? Name {  get; set; }
    public string? Lastname { get; set; }
    public string? Email { get; set; }
    public bool Status { get; set; } = false;
    public string? PasswordHash { get; set; }
    public List<CitizenVehicle>? Vehicles { get; set; }
}
