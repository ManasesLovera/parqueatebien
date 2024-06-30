namespace backend.DTOs;

public record ChangeStatusDTO
(
    string LicensePlate,
    string NewStatus,
    string Username
)
{
    public bool Validate()
    {
        return LicensePlate != null && NewStatus != null &&
            new[] { "Reportado", "Incautado por grua", "Retenido", "Liberado" }
            .Any(s => s == NewStatus);
    }
};
