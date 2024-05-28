namespace Models
{
    public interface ICitizen
    {
        string LicensePlate { get; set; }
        string VehicleType { get; set; }
        string VehicleColor { get; set; }
        string Address { get; set; }
        string Lat { get; set; }
        string Lon { get; set; }
        List<Pictures> Pictures { get; set; }
    }
}