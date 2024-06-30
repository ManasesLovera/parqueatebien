namespace backend.DTOs
{
    public class CitizenLoginDto
    {
        required public string GovernmentId { get; set; }
        required public string Password { get; set; }
    }
}
