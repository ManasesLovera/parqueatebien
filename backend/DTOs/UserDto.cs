namespace backend.DTOs;

public class UserDto
{
    public string? EmployeeCode { get; set; }
    public string? Name { get; set; }
    public string? Lastname { get; set; }
    public string? Username {  get; set; }
    public string? Password { get; set; }
    public bool Status { get; set; }
    public string? Role { get; set; }
    public string? CraneCompany { get; set; }
}