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
  public Ciudadano? GetCiudadano(string matricula) {

    Ciudadano ciudadano = connectiondb.GetByMatricula(matricula);

    return ciudadano;
  }

  // POST
  public Ciudadano AddCiudadano(Ciudadano ciudadano) {
    
    return connectiondb.Add(ciudadano);
  }

  // PUT
  // public Ciudadano UpdateCiudadano(Ciudadano ciudadano) {

  // }
}

public class Ciudadano {

  public string? Photo { get; set; }
  public string? GPS { get; set; }
  public string? Matricula { get; set; }

}


