namespace Models
{
    public interface ICitizen
    {
        string Address { get; set; }
        string Description { get; set; }
        string? File { get; set; }
        string? FileType { get; set; }
        string Lat { get; set; }
        string LicensePlate { get; set; }
        string Lon { get; set; }
        string VehicleColor { get; set; }
    }
}