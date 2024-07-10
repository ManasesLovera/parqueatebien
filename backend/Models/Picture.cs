using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class Picture { 
    public int Id { get; set; }
    public string? LicensePlate { get; set; }
    [Base64String]
    public string? File { get; set; }
    public string? FileType { get; set; }
};