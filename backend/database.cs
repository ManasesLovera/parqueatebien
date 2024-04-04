using Microsoft.Data.Sqlite;
using Services;

namespace db;

public class DbConnection
{
    private static readonly string connectionString = "Data Source=database.db";
    public DbConnection()
    {
        InitializaDatabase();
    }

    private void InitializaDatabase()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Ciudadanos (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Photo TEXT,
                GPS TEXT,
                Matricula TEXT
            )
            ";
            command.ExecuteNonQuery();
            connection.Close();
        }
    }

    public List<Ciudadano> GetAll()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            SELECT Photo,GPS,Matricula FROM Ciudadanos
            ";            

            List<Ciudadano> ciudadanos = new List<Ciudadano>();

            using (var reader = cmd.ExecuteReader())
            {
                while(reader.Read())
                {
                    ciudadanos.Add(
                        new Ciudadano
                        {
                            Photo = reader["Photo"].ToString(),
                            GPS = reader["GPS"].ToString(),
                            Matricula = reader["Matricula"].ToString()
                        }
                    );
                }
            }
            return ciudadanos;
            connection.Close();
        }
    }

    public Ciudadano GetByMatricula(string matricula)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
            Ciudadano? ciudadano = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"
            SELECT Photo, GPS, Matricula FROM Ciudadanos WHERE Matricula = @matricula
            ";
            command.Parameters.AddWithValue("@matricula", matricula);

            var reader = command.ExecuteReader();

            if (reader.Read())
            {
                ciudadano = new Ciudadano {
                    Photo = reader["Photo"].ToString(),
                    GPS = reader["GPS"].ToString(),
                    Matricula = reader["Matricula"].ToString()
                };
            }

            return ciudadano;
            connection.Close();
            }
        }
        catch(Exception ex)
        {
            return new Ciudadano{
                Photo = ex.Message,
                GPS = ex.Message,
                Matricula = null
            };
        }
        
    }

    public Ciudadano Add(Ciudadano ciudadano)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();

                var cmd = connection.CreateCommand();
                cmd.CommandText = @"
                INSERT INTO Ciudadanos (Photo, GPS, Matricula)
                VALUES (@photo, @gps, @matricula)
                ";
                cmd.Parameters.AddWithValue("@photo", ciudadano.Photo);
                cmd.Parameters.AddWithValue("@gps", ciudadano.GPS);
                cmd.Parameters.AddWithValue("@matricula", ciudadano.Matricula);

                cmd.ExecuteNonQuery();

                connection.Close();
            }
            return ciudadano;
        }
        catch (Exception ex)
        {
            return new Ciudadano{
                Photo = ex.Message.ToString(),
                GPS = ex.Message.ToString(),
                Matricula = null
            };
        }
    }

    public Ciudadano Update(Ciudadano ciudadano)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();

                var command = connection.CreateCommand();
                command.CommandText = @"
                UPDATE Ciudadanos
                SET Photo = @photo, GPS = @gps
                WHERE Matricula = @matricula
                ";
                command.Parameters.AddWithValue("@photo", ciudadano.Photo);
                command.Parameters.AddWithValue("@gps", ciudadano.GPS);
                command.Parameters.AddWithValue("@matricula", ciudadano.Matricula);

                command.ExecuteNonQuery();

                connection.Close();
            }
            return this.GetByMatricula(ciudadano.Matricula);
        }
        catch (Exception ex)
        {
            return new Ciudadano
            {
                Photo = ex.Message,
                GPS = ex.Message,
                Matricula = null
            };
        }
    }

}