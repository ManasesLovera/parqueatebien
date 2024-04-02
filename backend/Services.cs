namespace Services;

class Ciudadanos {
  public List<Ciudadano> ciudadanos = new List<Ciudadano>();

  public List<Ciudadano> GetCiudadanos() {
    return this.ciudadanos;
  }

  public Ciudadano GetCiudadano(string matricula) {

    var ciudadano = ciudadanos.SingleOrDefault(c => c.Matricula == matricula);

    return ciudadano;
  }

  public Ciudadano AddCiudadano(Ciudadano ciudadano) {
    this.ciudadanos.Add(ciudadano);
    return ciudadano;
  }
}

class Ciudadano {

  // Id
  public string? Photo { get; set; }
  public string? GPS { get; set; }
  public string? Matricula { get; set; }
  //bool recogido = false;
  // Por que el amet se llevo el vehiculo
  // Como o que necesito para recoger mi vehiculo
}
