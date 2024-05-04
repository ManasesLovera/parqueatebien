using Newtonsoft.Json; // Serialization/Deserialization for JSON
using db;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Text.RegularExpressions;

namespace Services;

public class CitizensService
{
  // Database
  public DbConnection connectiondb = new DbConnection();

  // GET ALL
  public List<Citizen> GetCitizens()
  {
    // Show all data
    return connectiondb.GetAll();
  }

    // ValidateGetCitizenRequest
    // que reciba un httpcontext que me diga si es valido
    // que me devuelva el license plate
    // si no es valido que devuelva un bad request
    // debe verificar si el licenseplate esta en el http context
    // cuando el getcitizen mande un null debe responder con un NotFound 404

  // GET
  public Citizen? GetCitizen(string licensePlate)
  {
        // Get the citizen using the licensePlate and returns it
        return connectiondb.GetByLicensePlate(licensePlate);
  }
  // Validate bool
  public string? ValidateGetCitizenRequest(HttpContext context)
    {
        // Take the "licensePlate" string from the endpoint
        string? licensePlate = context.Request.RouteValues["licensePlate"]!.ToString();

        // Verify if the licensePlate is not null, it only contains 7 letters, but also only Uppercase letters, numbers and hyphens
        if (licensePlate != null && licensePlate!.Trim().Length >= 5 && licensePlate!.Trim().Length <= 7 && Regex.IsMatch(licensePlate, "^[A-Z0-9-]*$"))
            return licensePlate;

        // If it doesn't comply with the conditions it will return null
        return null;
    }

  // POST
  public Res AddCitizen(HttpContext context)
  {
    try
    {
      Console.WriteLine("AddCitizen");
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Citizen citizen = JsonConvert.DeserializeObject<Citizen>(body)!;
        Console.WriteLine(body);

        bool sonString = (!string.IsNullOrEmpty(citizen.licensePlate) && citizen.licensePlate is string) &&
        (!string.IsNullOrEmpty(citizen.description) && citizen.description is string) &&
        (!string.IsNullOrEmpty(citizen.lat) && citizen.lat is string) &&
        (!string.IsNullOrEmpty(citizen.lon) && citizen.lon is string) &&
        (!string.IsNullOrEmpty(citizen.file)) && (citizen.fileType is string);

        if (!sonString)
        {
          context.Response.StatusCode = 400;
          return new Res
          {
            citizen = null,
            message = "Missing info or invalid data"
          };
        }
        if (connectiondb.Exists(citizen.licensePlate))
        {
          context.Response.StatusCode = 400;
          return new Res
          {
            citizen = null,
            message = "Citizen already exist"
          };
        }
        var citizenRes = connectiondb.Add(citizen);
        if (citizenRes.citizen == null)
        {
          context.Response.StatusCode = 500;
          return new Res { citizen = null, message = citizenRes.message };
        }
        return new Res { citizen = citizenRes.citizen, message = "" };
      }
    }
    catch (Exception ex)
    {
      context.Response.StatusCode = 500;
      return new Res
      {
        citizen = null,
        message = ex.Message
      };
    }
  }
  // PUT
  public Res? UpdateCitizen(HttpContext context)
  {
    try
    {
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Citizen citizen = JsonConvert.DeserializeObject<Citizen>(body);

        bool sonString = (!string.IsNullOrEmpty(citizen.licensePlate) && citizen.licensePlate is string) &&
                        (!string.IsNullOrEmpty(citizen.description) && citizen.description is string) &&
                        (!string.IsNullOrEmpty(citizen.lat) && citizen.lat is string) &&
                        (!string.IsNullOrEmpty(citizen.lon) && citizen.lon is string) &&
                        (!string.IsNullOrEmpty(citizen.file)) && (citizen.fileType is string);

        if (!sonString)
        {
          context.Response.StatusCode = 400;
          context.Response.ContentType = "application/json";
          return new Res
          {
            citizen = null,
            message = "Missing info or invalid format"
          }; // Missing info or data is not string
        }
        // Verify if citizen exist
        var citizenExist = connectiondb.Exists(citizen.licensePlate);
        if (!citizenExist)
        {
          context.Response.StatusCode = 404;
          return new Res
          {
            citizen = null,
            message = "Not Found"
          };
        }
        var citizenRes = connectiondb.Update(citizen);

        if (citizenRes.citizen == null)
        {
          context.Response.StatusCode = 500;
          return new Res
          {
            citizen = null,
            message = citizenRes.message
          };
        }
        return new Res
        {
          citizen = citizenRes.citizen,
          message = ""
        };
      }
    }

    catch (Exception e)
    {
      context.Response.StatusCode = 500;
      return new Res
      {
        citizen = null,
        message = e.Message
      };
    }
  }

  // DELETE
  public string DeleteCitizen(HttpContext context)
  {
    try
    {
      string? licensePlate = context.Request.RouteValues["licensePlate"].ToString();
      var citizen = connectiondb.GetByLicensePlate(licensePlate);
      if (citizen == null)
      {
        context.Response.StatusCode = 404;
        return $"This Citizen does not exist or is not a valid data: {licensePlate}";
      }
      return connectiondb.Delete(licensePlate);
    }
    catch (Exception ex)
    {
      context.Response.StatusCode = 500;
      return ex.Message;
    }
  }
}

public class Res
{
  public Citizen? citizen { get; set; }
  public string message { get; set; } = String.Empty;
}

public class Citizen
{

  public string licensePlate { get; set; } = String.Empty;
  public string description { get; set; } = String.Empty;
  public string lat { get; set; } = String.Empty;
  public string lon { get; set; } = String.Empty;
  public string? file { get; set; }
  public string fileType { get; set; } = String.Empty;

}