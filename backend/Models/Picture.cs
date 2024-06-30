namespace backend.Models;

public class Picture { 
    required public int Id { get; set; }
    required public string File { get; set; }
    required public string FileType { get; set; }
    required public string LicensePlate { get; set; }
};