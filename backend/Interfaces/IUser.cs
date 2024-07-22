namespace backend.Interfaces;
// Interface for both Employees and Citizens
public interface IUser
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Lastname { get; set; }
    public string? PasswordHash { get; set; }
}
