namespace Models;

public record ChangeStatusDTO
( 
    string LicensePlate,
    string NewStatus
)
{
    public bool Validate()
    {
        return (LicensePlate != null && NewStatus != null &&
            (new[] { "Reportado", "Incautado por grua", "Retenido", "Liberado" }
            .Any(s => s == NewStatus)));
    }
    public bool ValidateUpdate()
    {
        return (LicensePlate != null && NewStatus != null &&
            (new[] { "Reportado", "Incautado por grua", "Retenido" }
            .Any(s => s == NewStatus)));
    }
};
