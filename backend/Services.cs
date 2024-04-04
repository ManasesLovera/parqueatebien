using Newtonsoft.Json;
using db;

namespace Services;

public class Ciudadanos {
  public DbConnection connectiondb = new DbConnection();
  public List<Ciudadano> ciudadanos = new List<Ciudadano>();

  public Ciudadanos() 
  {
    this.LoadData();
  }

  public void LoadData()
  {
    this.ciudadanos = connectiondb.GetAll();
  }

  public List<Ciudadano> GetCiudadanos() {
    this.LoadData();
    return this.ciudadanos;
  }

  // GET
  public Ciudadano? GetCiudadano(string matricula) 
  {
    Ciudadano ciudadano = connectiondb.GetByMatricula(matricula);

    return ciudadano;
  }

  // POST
  public Ciudadano AddCiudadano(Ciudadano ciudadano) 
  {
    return connectiondb.Add(ciudadano);
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
        
        if(ciudadano == null || (ciudadano.Photo == null || ciudadano.GPS == null || ciudadano.Matricula == null))
        {
          context.Response.StatusCode = 400;
          context.Response.ContentType = "application/json";
          return new Ciudadano{
            Photo = "Missing Info",
            GPS = "Missing Info",
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
        Photo = e.Message.ToString(),
        GPS = e.Message.ToString(),
        Matricula = null
      };
    }
  }
}
public class Ciudadano {

  public string? Photo { get; set; }
  public string? GPS { get; set; }
  public string? Matricula { get; set; }

}


