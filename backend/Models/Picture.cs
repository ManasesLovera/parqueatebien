using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace backend.Models;
// Photos of the vehicle once an agent reports it
public class Picture { 
    public int Id { get; set; }
    [ForeignKey("FK_LicensePlate")]
    public string? LicensePlate { get; set; }
    [Base64String]
    public string? File { get; set; }
    public string? FileType { get; set; }
    public Report? Report { get; set; }
};