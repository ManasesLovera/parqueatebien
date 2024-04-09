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
            CREATE TABLE IF NOT EXISTS Citizens (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Photo BLOB,
                Lat VARCHAR(60),
                Lon VARCHAR(60),
                LicensePlate VARCHAT(30)
            )";
            command.ExecuteNonQuery();
            connection.Close();
        }
    }

    public List<Citizen> GetAll()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            SELECT Photo,Lat,Lon,LicensePlate FROM Citizens
            ";            

            List<Citizen> citizens = new List<Citizen>();

            using (var reader = cmd.ExecuteReader())
            {
                while(reader.Read())
                {
                    string photoBase64 = Convert.ToBase64String((byte[])reader["Photo"]);

                    citizens.Add(
                        new Citizen
                        {
                            Photo = photoBase64,
                            Location = new Coordinates {
                                Lat = reader["Lat"].ToString(),
                                Lon = reader["Lon"].ToString(),
                            },
                            LicensePlate = reader["LicensePlate"].ToString()
                        }
                    );
                }
            }
            connection.Close();
            return citizens;
        }
    }

    public Citizen? GetByLicensePlate(string licensePlate)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
            Citizen? citizen = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"
            SELECT Photo, Lat, Lon, LicensePlate FROM Citizens WHERE LicensePlate = @licensePlate
            ";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);

            var reader = command.ExecuteReader();

            if (reader.Read())
            {
                string photoBase64 = Convert.ToBase64String((byte[])reader["Photo"]);

                citizen = new Citizen {
                    Photo = photoBase64,
                    Location = new Coordinates{
                        Lat = reader["Lat"].ToString(), 
                        Lon = reader["Lon"].ToString()
                        },
                    LicensePlate = reader["LicensePlate"].ToString()
                };
            }

            connection.Close();
            return citizen;
            }
        }
        catch(Exception ex)
        {
            return new Citizen{
                Photo = ex.Message,
                Location = new Coordinates {Lat = "", Lon = ""},
                LicensePlate = null
            };
        }
    }

    // Verify if Citizen exists
    public bool Exists(string licensePlate)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = "SELECT LicensePlate FROM Citizens WHERE LicensePlate = @licensePlate";
                command.Parameters.AddWithValue("@licensePlate", licensePlate);

                using (var reader = command.ExecuteReader())
                {
                    if(reader.Read())
                    {
                        return true;
                    }
                    else
                    {
                        return false;
                    }
                }
            }
        }
        catch(Exception)
        {
            return false;
        }
    }

    public Res Add(Citizen citizen)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();

                var cmd = connection.CreateCommand();
                cmd.CommandText = @"
                INSERT INTO Citizens (Photo, Lat, Lon, LicensePlate)
                VALUES (@photo, @lat, @lon, @licensePlate)
                ";

                byte[] photoBytes = Convert.FromBase64String((citizen.Photo));

                cmd.Parameters.AddWithValue("@photo", photoBytes);
                cmd.Parameters.AddWithValue("@lat", citizen.Location.Lat);
                cmd.Parameters.AddWithValue("@lon", citizen.Location.Lon);
                cmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);

                cmd.ExecuteNonQuery();

                connection.Close();
            }
            return new Res { citizen = citizen, message = "" };
        }
        catch (Exception ex)
        {
            return new Res {
                citizen = null,
                message = ex.Message
            };
        }
    }

    public Res? Update(Citizen citizen)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();

                var command = connection.CreateCommand();
                command.CommandText = @"
                UPDATE Citizens
                SET Photo = @photo, Lat = @lat, Lon = @lon
                WHERE LicensePlate = @licensePlate
                ";

                byte[] photoBytes = Convert.FromBase64String(citizen.Photo);

                command.Parameters.AddWithValue("@photo", photoBytes);
                command.Parameters.AddWithValue("@lat", citizen.Location.Lat);
                 command.Parameters.AddWithValue("@lon", citizen.Location.Lon);
                command.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);

                command.ExecuteNonQuery();

                connection.Close();
            }
            return new Res { citizen = this.GetByLicensePlate(citizen.LicensePlate), message = "" };
        }
        catch (Exception ex)
        {
            return new Res
            {
                citizen = null,
                message = ex.Message
            };
        }
    }

    public string Delete(string licensePlate)
    {
        try
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();

                var command = connection.CreateCommand();
                command.CommandText = @"
                DELETE FROM Citizens WHERE LicensePlate = @licensePlate
                ";
                command.Parameters.AddWithValue("@licensePlate", licensePlate);
                command.ExecuteNonQuery();

                connection.Close();

                return "Deleted successfully";
            }
        }
        catch(Exception ex)
        {
            return ex.Message;
        }
    }

}