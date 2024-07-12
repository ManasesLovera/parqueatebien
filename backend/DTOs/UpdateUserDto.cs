namespace backend.DTOs;

public class UpdateUserDto
{
    public string? EmployeeCode { get; set; }
    public string? Username { get; set; }
    public bool Status { get; set; }
    public string? Role { get; set; }
    public string? CraneCompany { get; set; }
}
