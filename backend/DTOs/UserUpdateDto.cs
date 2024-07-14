namespace backend.DTOs;

public class UserUpdateDto
{
    public string? EmployeeCode { get; set; }
    public bool Status { get; set; }
    public string? Role { get; set; }
    public string? CraneCompany { get; set; }
}
