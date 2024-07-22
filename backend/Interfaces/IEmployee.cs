namespace backend.Interfaces;
// Interface for each Employee (Admin, Agente, Grua)
public interface IEmployee : IUser
{
    public string? EmployeeCode { get; set; }
    public string? Username { get; set; }
}
