﻿namespace Models
{
    public class Citizen
    {
        public string LicensePlate { get; set; } = String.Empty;
        public string VehicleType { get; set; } = String.Empty;
        public string VehicleColor { get; set; } = String.Empty;
        public string Address { get; set; } = String.Empty;
        public string Status { get; set; } = string.Empty;
        public string CurrentAddress {  get; set; } = String.Empty;
        public string ReportedDate { get; set;} = String.Empty;
        public string? TowedByCraneDate {  get; set; } = null;
        public string? ArrivalAtParkinglot { get; set; } = null;
        public string? ReleaseDate { get; set; } = null;
        public string Lat { get; set; } = String.Empty;
        public string Lon { get; set; } = String.Empty;
        public List<Pictures> Photos { get; set; } = new List<Pictures>();
    }
}
