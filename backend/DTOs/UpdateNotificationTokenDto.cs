namespace backend.DTOs;

public class UpdateNotificationTokenDto
{
    required public string GovernmentId { get; set; }
    required public string NotificationToken { get; set; }
}
