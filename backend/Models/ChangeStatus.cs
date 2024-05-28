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
            (new[] { "Reportado", "Incautado por grúa", "Retenido", "Liberado" }
            .Any(s => s == NewStatus)));
    }
};
