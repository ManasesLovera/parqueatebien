using System.ComponentModel.DataAnnotations;

namespace backend.Models;
// Model for Crane company
public class CraneCompany
{
    [Key]
    public int Id { get; set; }
    public string? RNC { get; set; }
    public string? CompanyName { get; set; }
    [Phone]
    public string? PhoneNumber { get; set; }
    public int AmountCraneAgents { get; set; } = 0;
}
