namespace Models
{
    public class Citizen
    {
        public string LicensePlate { get; set; } = String.Empty;
        public string Description { get; set; } = String.Empty;
        public string Address { get; set; } = String.Empty;
        public string VehicleColor { get; set; } = String.Empty;
        public string Lat { get; set; } = String.Empty;
        public string Lon { get; set; } = String.Empty;
        public string? File { get; set; }
        public string? FileType { get; set; } = String.Empty;
        
    }
}
