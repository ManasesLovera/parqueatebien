namespace backend.Models;

public interface IUser
{
    public int Id { get; set; }
    public string? Name { get; set; }
    public string? Lastname { get; set; }
    public bool Status { get; set; }
    public string? PasswordHash { get; set; }
}
