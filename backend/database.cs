using Microsoft.Data.Sqlite;
using Services;
using System.Data.Common;

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
                LicensePlate VARCHAR(30),
                Description VARCHAR(100),
                Lat VARCHAR(60),
                Lon VARCHAR(60),
                File BLOB,
                FileType VARCHAR(40)
                
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
            SELECT LicensePlate,Description,Lat,Lon,File,FileType FROM Citizens
            ";

            List<Citizen> citizens = new List<Citizen>();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    string photoBase64 = Convert.ToBase64String((byte[])reader["File"]);

                    citizens.Add(
                        new Citizen
                        {
                            LicensePlate = reader["LicensePlate"].ToString(),
                            Description = reader["Description"].ToString(),
                            Lat = reader["Lat"].ToString(),
                            Lon = reader["Lon"].ToString(),
                            File = photoBase64,
                            FileType = reader["FileType"].ToString()
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
            if (!this.Exists(licensePlate)) return null;

            using (var connection = new SqliteConnection(connectionString))
            {
                Citizen? citizen = null;
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = @"
            SELECT LicensePlate, Description, Lat, Lon, File, FileType  FROM Citizens WHERE LicensePlate = @licensePlate
            ";
                command.Parameters.AddWithValue("@licensePlate", licensePlate);

                var reader = command.ExecuteReader();

                if (reader.Read())
                {
                    string photoBase64 = Convert.ToBase64String((byte[])reader["File"]);

                    citizen = new Citizen
                    {

                        LicensePlate = reader["LicensePlate"].ToString()!,
                        Description = reader["Description"].ToString()!,
                        Lat = reader["Lat"].ToString()!,
                        Lon = reader["Lon"].ToString()!,
                        File = photoBase64,
                        FileType = reader["FileType"].ToString()!
                    };
                }

                connection.Close();
                return citizen;
            }
        }
        catch (Exception ex)
        {
            throw new Exception("An error occured" + ex.Message);
        }
    }

    // Verify if Citizen exists
    public bool Exists(string licensePlate)
    {

        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = "SELECT LicensePlate FROM Citizens WHERE LicensePlate = @licensePlate";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);

            using (var reader = command.ExecuteReader())
            {
                if (reader.Read())
                {
                    return true;
                }
                return false;
            }
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
                INSERT INTO Citizens (LicensePlate, Description, Lat, Lon, File, FileType)
                VALUES (@licensePlate, @description, @lat, @lon, @file, @fileType)
                ";

                byte[] photoBytes = Convert.FromBase64String(citizen.File);

                cmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
                cmd.Parameters.AddWithValue("@description", citizen.Description);
                cmd.Parameters.AddWithValue("@lat", citizen.Lat);
                cmd.Parameters.AddWithValue("@lon", citizen.Lon);
                cmd.Parameters.AddWithValue("@file", photoBytes);
                cmd.Parameters.AddWithValue("@fileType", citizen.FileType);


                cmd.ExecuteNonQuery();

                connection.Close();
            }
            return new Res { Citizen = citizen, Message = "" };
        }
        catch (Exception ex)
        {
            return new Res
            {
                Citizen = null,
                Message = ex.Message
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
                SET Description = @description, Lat = @lat, Lon = @lon, File = @file, FileType = @fileType
                WHERE LicensePlate = @licensePlate
                ";

                byte[] photoBytes = Convert.FromBase64String(citizen.File);

                command.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
                command.Parameters.AddWithValue("@description", citizen.Description);
                command.Parameters.AddWithValue("@lat", citizen.Lat);
                command.Parameters.AddWithValue("@lon", citizen.Lon);
                command.Parameters.AddWithValue("@file", photoBytes);
                command.Parameters.AddWithValue("fileType", citizen.FileType);

                command.ExecuteNonQuery();

                connection.Close();
            }
            return new Res { Citizen = this.GetByLicensePlate(citizen.LicensePlate), Message = "" };
        }
        catch (Exception ex)
        {
            return new Res
            {
                Citizen = null,
                Message = ex.Message
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
        catch (Exception ex)
        {
            return ex.Message;
        }
    }

}