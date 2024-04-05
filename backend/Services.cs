using Newtonsoft.Json; // Serialization/Deserialization for JSON
using db;

namespace Services;

public class Ciudadanos {
  // Database
  public DbConnection connectiondb = new DbConnection();

  // GET ALL
  public List<Ciudadano> GetCiudadanos() {
    // Show all data
    return connectiondb.GetAll();
  }

  // GET
  public Ciudadano? GetCiudadano(HttpContext context) 
  {
    try
    {
      // Take the "matricula" string from the endpoint
      string matricula = context.Request.RouteValues["matricula"].ToString();

      // Verify if matricula exists
      if(string.IsNullOrEmpty(matricula))
      {
        context.Response.StatusCode = 400;
        return new Ciudadano {
          Photo = $"Matricula was not found, you must add it to the endpoint ${matricula}",
          GPS = $"Matricula was not found, you must add it to the endpoint ${matricula}",
          Matricula = null
        };
      }
      // Search the ciudadano using the matricula
      Ciudadano ciudadano = connectiondb.GetByMatricula(matricula);
      // Verify if ciudadano exists
      if(ciudadano == null)
      {
        context.Response.StatusCode = 404;
        return new Ciudadano {
          Photo = "Not found",
          GPS = "Not found",
          Matricula = null
        };
      }
      return ciudadano;
    }
    // Show error if an exception
    catch (Exception ex)
    {
      return new Ciudadano{
        Photo = ex.Message,
        GPS = ex.Message,
        Matricula = null
      };
    }
  }

  // POST
  public Ciudadano AddCiudadano(HttpContext context) 
  {
    try{
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Ciudadano ciudadano = JsonConvert.DeserializeObject<Ciudadano>(body);

        bool sonString = (!string.IsNullOrEmpty(ciudadano.Photo) && ciudadano.Photo is string) &&
                        (!string.IsNullOrEmpty(ciudadano.GPS) && ciudadano.GPS is string) &&
                        (!string.IsNullOrEmpty(ciudadano.Matricula) && ciudadano.Matricula is string);
      
        if (!sonString)
        {
          context.Response.StatusCode = 400;
          return new Ciudadano {
            Photo = "Missing info or data is not in the correct format",
            GPS = "Missing info or data is not in the correct format",
            Matricula = null
          };
        }
        if(connectiondb.Exists(ciudadano.Matricula))
        {
          context.Response.StatusCode = 400;
          return new Ciudadano {
            Photo = "This Ciudadano already exists",
            GPS = "This Ciudadano already exists",
            Matricula = null
          };
        }
        return connectiondb.Add(ciudadano);
      }
    }
    catch (Exception ex)
    {
      return new Ciudadano {
        Photo = ex.Message,
        GPS = ex.Message,
        Matricula = null
      };
    }
    
  }

  // PUT
  public Ciudadano UpdateCiudadano(HttpContext context) 
  {
    try
    {
      using (StreamReader reader = new StreamReader(context.Request.Body))
      {
        string body = reader.ReadToEndAsync().GetAwaiter().GetResult();

        Ciudadano ciudadano = JsonConvert.DeserializeObject<Ciudadano>(body);

        bool isString = (!string.IsNullOrEmpty(ciudadano.Photo) && ciudadano.Photo is string) &&
                        (!string.IsNullOrEmpty(ciudadano.GPS) && ciudadano.GPS is string) &&
                        (!string.IsNullOrEmpty(ciudadano.Matricula) && ciudadano.Matricula is string);
        
        if(!isString)
        {
          context.Response.StatusCode = 400;
          context.Response.ContentType = "application/json";
          return new Ciudadano{
            Photo = "Missing Info or data is not string",
            GPS = "Missing Info or data is not string",
            Matricula = null
          };
        }
        // Si envia nulo es que no existe, si envia un Ciudadano es que se modifico con exito
        var c = connectiondb.Update(ciudadano);

        if(c == null)
        {
          context.Response.StatusCode = 404;
          context.Response.ContentType = "application/json";
          return new Ciudadano {
          Photo = "Not Found",
          GPS = "Not Found",
          Matricula = null
          };
        }
        return c;
      }
    }
  
    catch (Exception e)
    {
      context.Response.StatusCode = 400;
      context.Response.ContentType = "application/json";
      return new Ciudadano 
      {
        Photo = e.Message,
        GPS = e.Message,
        Matricula = null
      };
    }
  }

  // DELETE
  public string DeleteCiudadano(HttpContext context)
  {
    string matricula = context.Request.RouteValues["matricula"].ToString();
    var ciudadano = connectiondb.GetByMatricula(matricula);
    if(ciudadano == null)
    {
      context.Response.StatusCode = 404;
      return $"This Ciudadano does not exist or is not a valid data ${matricula}";
    }
    return connectiondb.Delete(matricula);
  }
}
public class Ciudadano {

  public string? Photo { get; set; }
  public string? GPS { get; set; }
  public string? Matricula { get; set; }

}