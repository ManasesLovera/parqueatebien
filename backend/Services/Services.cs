using Newtonsoft.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.RegularExpressions;
using System.ComponentModel;
using backend.Models;
using backend.DTOs;

namespace backend.Services;

public struct ValidationResult<T>
{
    public T? Result { get; set; }
    public List<string> ErrorMessages { get; set; }
}

public class ReportsService
{
    //public DbConnection connectiondb = new DbConnection();

    //public ValidationResult<string> ValidateReportRequest(string licensePlate)
    //{
    //    if (licensePlate == null)
    //    {
    //        return new ValidationResult<string>() { Result = null, ErrorMessages = new List<string>() { "Route parameter 'licensePlate' was not provided." } };
    //    }
    //    if (licensePlate!.Trim().Length >= 5 && licensePlate!.Trim().Length <= 7 && Regex.IsMatch(licensePlate, "^[A-Z0-9-]*$"))
    //    {
    //        return new ValidationResult<string>() { Result = licensePlate, ErrorMessages = new() };
    //    }
    //    else
    //    {
    //        return new ValidationResult<string>() { Result = null, ErrorMessages = new List<string>() { $"License plate '{licensePlate}' is invalid." } };
    //    }
    //}
    //public bool ValidateCitizenBody(ReportDto citizen) =>
    //    !string.IsNullOrEmpty(citizen!.LicensePlate) && citizen.LicensePlate is string &&
    //    !string.IsNullOrEmpty(citizen.VehicleType) && citizen.VehicleType is string &&
    //    !string.IsNullOrEmpty(citizen.VehicleColor) && citizen.VehicleColor is string &&
    //    !string.IsNullOrEmpty(citizen.Lat) && citizen.Lat is string &&
    //    !string.IsNullOrEmpty(citizen.Lon) && citizen.Lon is string;


    //public bool ValidateRole(string? role)
    //{
    //    if (role == null)
    //        return false;

    //    return new[] { "Admin", "Supervisor", "Grua", "Agente" }.Any(r => r == role);
    //}
    //public List<string> VehicleStatus() =>
    //    DbConnection.GetAllCitizens().Select(report => report.Status!).ToList();

    //public Report? UpdateCitizen(Report report) =>
    //    connectiondb.UpdateCitizen(report);

}