namespace Models
{
    public interface ICitizen
    {
        string LicensePlate { get; set; }
        string VehicleType { get; set; }
        string VehicleColor { get; set; }
        string Address { get; set; }
        string? File { get; set; }
        string? FileType { get; set; }
        string Lat { get; set; }
        string Lon { get; set; }
        
    }
}