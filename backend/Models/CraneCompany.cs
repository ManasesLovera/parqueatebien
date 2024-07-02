namespace backend.Models;

public class CraneCompany
{
    public int Id { get; set; }
    public string? RNC { get; set; }
    public string? CompanyName { get; set; }
    public string? PhoneNumber { get; set; }
    public int AmountCraneAgents { get; set; } = 0;
}
