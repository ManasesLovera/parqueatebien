using Newtonsoft.Json; // Serialization/Deserialization for JSON
using System.IO;
using db;

namespace Services;

public class Citizens {
  // Database
  public DbConnection connectiondb = new DbConnection();

  // GET ALL
  public List<Citizen> GetCitizens() {
    // Show all data
    return connectiondb.GetAll();
  }

  // GET
  public Citizen? GetCitizen(HttpContext context) 
  {
    try
    {
      // Take the "licensePlate" string from the endpoint
      string licensePlate = context.Request.RouteValues["licensePlate"].ToString();

      // Verify if licensePlate exists
      if(string.IsNullOrEmpty(licensePlate))
      {
        context.Response.StatusCode = 400;
        return new Citizen {
          Photo = $"LicensePlate was not found, you must add it to the endpoint ${licensePlate}",
          GPS = $"LicensePlate was not found, you must add it to the endpoint ${licensePlate}",
          LicensePlate = null
        };
      }
      // Search the citizen using the licensePlate
      Citizen citizen = connectiondb.GetByLicensePlate(licensePlate);
      // Verify if citizen exists
      if(citizen == null)
      {
        context.Response.StatusCode = 404;
        return new Citizen {
          Photo = "Not found",
          GPS = "Not found",
          LicensePlate = null
        };
      }
      return citizen;
    }
    // Show error if an exception
    catch (Exception ex)
    {
      return new Citizen{
        Photo = ex.Message,
        GPS = ex.Message,
        LicensePlate = null
      };
    }
  }

  // POST
  public Citizen AddCitizen(HttpContext context) 
  {
    try{
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Citizen citizen = JsonConvert.DeserializeObject<Citizen>(body);

        bool sonString = (!string.IsNullOrEmpty(citizen.Photo) && citizen.Photo is string) &&
                        (!string.IsNullOrEmpty(citizen.GPS) && citizen.GPS is string) &&
                        (!string.IsNullOrEmpty(citizen.LicensePlate) && citizen.LicensePlate is string);
      
        if (!sonString)
        {
          context.Response.StatusCode = 400;
          return new Citizen {
            Photo = "Missing info or data is not in the correct format",
            GPS = "Missing info or data is not in the correct format",
            LicensePlate = null
          };
        }
        if(connectiondb.Exists(citizen.LicensePlate))
        {
          context.Response.StatusCode = 400;
          return new Citizen {
            Photo = "This Citizen already exists",
            GPS = "This Citizen already exists",
            LicensePlate = null
          };
        }
        return connectiondb.Add(citizen);
      }
    }
    catch (Exception ex)
    {
      context.Response.StatusCode = 400;
      return new Citizen {
        Photo = ex.Message,
        GPS = ex.Message,
        LicensePlate = null
      };
    }
    
  }

  // PUT
  public Citizen UpdateCitizen(HttpContext context) 
  {
    try
    {
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Citizen citizen = JsonConvert.DeserializeObject<Citizen>(body);

        bool sonString = (!string.IsNullOrEmpty(citizen.Photo) && citizen.Photo is string) &&
                        (!string.IsNullOrEmpty(citizen.GPS) && citizen.GPS is string) &&
                        (!string.IsNullOrEmpty(citizen.LicensePlate) && citizen.LicensePlate is string);
        
        if(!sonString)
        {
          context.Response.StatusCode = 400;
          context.Response.ContentType = "application/json";
          return new Citizen{
            Photo = "Missing Info or data is not string",
            GPS = "Missing Info or data is not string",
            LicensePlate = null
          };
        }
        // Si envia nulo es que no existe, si envia un Citizen es que se modifico con exito
        var c = connectiondb.Update(citizen);

        if(c == null)
        {
          context.Response.StatusCode = 404;
          context.Response.ContentType = "application/json";
          return new Citizen {
          Photo = "Not Found",
          GPS = "Not Found",
          LicensePlate = null
          };
        }
        return c;
      }
    }
  
    catch (Exception e)
    {
      context.Response.StatusCode = 400;
      context.Response.ContentType = "application/json";
      return new Citizen 
      {
        Photo = e.Message,
        GPS = e.Message,
        LicensePlate = null
      };
    }
  }

  // DELETE
  public string DeleteCitizen(HttpContext context)
  {
    string licensePlate = context.Request.RouteValues["licensePlate"].ToString();
    var citizen = connectiondb.GetByLicensePlate(licensePlate);
    if(citizen == null)
    {
      context.Response.StatusCode = 404;
      return $"This Citizen does not exist or is not a valid data ${licensePlate}";
    }
    return connectiondb.Delete(licensePlate);
  }
}
public class Citizen {

  public string? Photo { get; set; }
  public string? GPS { get; set; }
  public string? LicensePlate { get; set; }

}