using Newtonsoft.Json; // Serialization/Deserialization for JSON
using System.IO;
using db;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Services;

public class CitizensService {
  // Database
  public DbConnection connectiondb = new DbConnection();

  // GET ALL
  public List<Citizen> GetCitizens() {
    // Show all data
    return connectiondb.GetAll();
  }

  // GET
  public Res GetCitizen(HttpContext context) 
  {
    try
    {
      // Take the "licensePlate" string from the endpoint
      string licensePlate = context.Request.RouteValues["licensePlate"].ToString();

      // Search the citizen using the licensePlate
      Citizen citizen = connectiondb.GetByLicensePlate(licensePlate);
      // Verify if citizen exists
      if(citizen == null)
      {
        context.Response.StatusCode = 404;
        return new Res {
          citizen = null,
          message = "Not Found"
        };
        
      }
      return new Res {citizen = citizen, message = ""};
    }
    // Show error if an exception
    catch (Exception ex)
    {
      context.Response.StatusCode = 500;
      return new Res {citizen = null,message = ex.Message};
    }
  }

  // POST
  public async Task<Res> AddCitizen(HttpContext context) 
  {
    try{
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = await reader.ReadToEndAsync();

        Citizen citizen = JsonConvert.DeserializeObject<Citizen>(body);

        bool sonString = (!string.IsNullOrEmpty(citizen.Photo) && citizen.Photo is string) &&
                        (!string.IsNullOrEmpty(citizen.Location.Lat) && citizen.Location.Lat is string) &&
                        (!string.IsNullOrEmpty(citizen.Location.Lon) && citizen.Location.Lon is string) &&
                        (!string.IsNullOrEmpty(citizen.LicensePlate) && citizen.LicensePlate is string);
      
        if (!sonString)
        {
          context.Response.StatusCode = 400;
          return new Res {
            citizen = null,
            message = "Missing info or invalid data"
          };
        }
        if(connectiondb.Exists(citizen.LicensePlate))
        {
          context.Response.StatusCode = 400;
          return new Res {
            citizen = null,
            message = "Citizen already exist"
          };
        }
        var citizenRes = connectiondb.Add(citizen);
        if (citizenRes.citizen == null)
           {
              return new Res {citizen = null, message = citizenRes.message };
           }
        return new Res {citizen = citizenRes.citizen, message = ""};
      }
    }
    catch (Exception ex)
    {
      context.Response.StatusCode = 500;
      return new Res {
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

        bool sonString = (!string.IsNullOrEmpty(citizen.Photo)) &&
                        (!string.IsNullOrEmpty(citizen.Location.Lat) && citizen.Location.Lat is string) &&
                        (!string.IsNullOrEmpty(citizen.Location.Lon) && citizen.Location.Lon is string) &&
                        (!string.IsNullOrEmpty(citizen.LicensePlate) && citizen.LicensePlate is string);
        
        if(!sonString)
        {
          context.Response.StatusCode = 400;
          context.Response.ContentType = "application/json";
          return new Res {
            citizen = null,
            message = "Missing info or invalid format"
          }; // Missing info or data is not string
        }
        // Verify if citizen exist
        var citizenExist = connectiondb.Exists(citizen.LicensePlate);
        if (!citizenExist)
           {
              context.Response.StatusCode = 404;
              return new Res {
                  citizen = null,
                  message = "Not Found"
              };
           }
        var citizenRes = connectiondb.Update(citizen);

        if(citizenRes.citizen == null)
        {
          context.Response.StatusCode = 500;
          return new Res {
            citizen = null,
            message = citizenRes.message
          };
        }
        return new Res {
          citizen = citizenRes.citizen,
          message = ""
        };
      }
    }
  
    catch (Exception e)
    {
      context.Response.StatusCode = 500;
      return new Res {
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
      if(citizen == null)
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

public class Res {
    public Citizen? citizen { get; set; }
    public string message { get; set; } = String.Empty;
}

public class Citizen {

    public string? Photo { get; set; }
    public Coordinates? Location { get; set; }
    public string LicensePlate { get; set; } = String.Empty;

}

public class Coordinates {

    public string Lat { get; set; } = String.Empty;
    public string Lon { get; set; } = String.Empty;

}