namespace backend.DTOs
{
    public class UserLoginDto
    {
        required public string Username { get; set; }
        required public string Password { get; set; }
        required public string Role { get; set; }
    }
}
