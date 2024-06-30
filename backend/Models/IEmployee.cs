namespace backend.Models;

public interface IEmployee : IUser
{
    public string? EmployeeCode { get; set; }
    public string? Username { get; set; }
}
