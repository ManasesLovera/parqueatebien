using Microsoft.Data.Sqlite;
using Models;
using System.Data;

namespace db;

public class DbConnection
{
    private static readonly string connectionString = "Data Source=database.db";
    public DbConnection()
    {
        InitializeDatabase();
    }

    private static void InitializeDatabase()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Citizens (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                LicensePlate VARCHAR(30) UNIQUE,
                VehicleType VARCHAR(100),
                VehicleColor VARCHAR(20),
                Address VARCHAR(100),
                Status VARCHAR(20),
                CurrentAddress VARCHAR(100),
                ReportedDate VARCHAR(100),
                TowedByCraneDate VARCHAR(100),
                ArrivalAtParkinglot VARCHAR(100),
                ReleaseDate VARCHAR(100),
                Lat VARCHAR(60),
                Lon VARCHAR(60),
                ReportedBy VARCHAR(30),
                ReleasedBy VARCHAR(30)
            )"; // Status: Reportado, Incautado por grua, Retenido, Liberado
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Pictures (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                File BLOB,
                FileType VARCHAR(40),
                LicensePlate VARCHAR(30),
                FOREIGN KEY (LicensePlate) REFERENCES Citizens(LicensePlate)
            )";
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Users (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                GovernmentID VARCHAR(50) UNIQUE,
                Password VARCHAR(255),
                Role VARCHAR(20) 
            )"; // Role could be (Admin, Supervisor, Agente, Grua)
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Roles (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Rol VARCHAR(100),
                IdPermiso INTEGER
            )
            ";
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Permisos (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                Id_User INTEGER,
                Visualizar INTEGER,
                Filtrar INTEGER,
                Crear_user INTEGER,
                Eliminar_user INTEGER,
                Enviar INTEGER,
                Crear_rol INTEGER,
                Eliminar_rol INTEGER,
                Exportar INTEGER
            )
            ";
            command.ExecuteNonQuery();

            connection.Close();
        }
    }
    public static List<Citizen> GetAllCitizens()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            SELECT * FROM Citizens
            ";

            List<Citizen> citizens = new List<Citizen>();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    citizens.Add(
                        new Citizen
                        {
                            LicensePlate = reader["LicensePlate"].ToString()!,
                            VehicleType = reader["VehicleType"].ToString()!,
                            Address = reader["Address"].ToString()!,
                            VehicleColor = reader["VehicleColor"].ToString()!,
                            Status = reader["Status"].ToString()!,
                            CurrentAddress = reader["CurrentAddress"].ToString()!,
                            ReportedBy = reader["ReportedBy"].ToString()!,
                            ReportedDate = reader["ReportedDate"].ToString()!,
                            TowedByCraneDate = reader["TowedByCraneDate"].ToString()!,
                            ArrivalAtParkinglot = reader["ArrivalAtParkinglot"].ToString()!,
                            ReleaseDate = reader["ReleaseDate"].ToString()!,
                            Lat = reader["Lat"].ToString()!,
                            Lon = reader["Lon"].ToString()!,
                            ReleasedBy = reader["ReleasedBy"].ToString()!,
                            Photos = GetPhotosByLicensePlate(reader["LicensePlate"].ToString()!),
                        }
                    );
                }
            }
            connection.Close();
            return citizens;
        }
    }
    public static Citizen? GetByLicensePlate(string licensePlate)
    {

        if (!CitizenExists(licensePlate)) return null;

        using (var connection = new SqliteConnection(connectionString))
        {
            Citizen? citizen = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"
        SELECT * FROM Citizens WHERE LicensePlate = @licensePlate
        ";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);

            var reader = command.ExecuteReader();

            if (reader.Read())
            {
                citizen = new Citizen
                {
                    LicensePlate = reader["LicensePlate"].ToString()!,
                    VehicleType = reader["VehicleType"].ToString()!,
                    Address = reader["Address"].ToString()!,
                    VehicleColor = reader["VehicleColor"].ToString()!,
                    Status = reader["Status"].ToString()!,
                    CurrentAddress = reader["CurrentAddress"].ToString()!,
                    ReportedBy = reader["ReportedBy"].ToString()!,
                    ReportedDate = reader["ReportedDate"].ToString()!,
                    TowedByCraneDate = reader["TowedByCraneDate"].ToString()!,
                    ArrivalAtParkinglot = reader["ArrivalAtParkinglot"].ToString()!,
                    ReleaseDate = reader["ReleaseDate"].ToString()!,
                    Lat = reader["Lat"].ToString()!,
                    Lon = reader["Lon"].ToString()!,
                    ReleasedBy = reader["ReleasedBy"].ToString()!,
                    Photos = GetPhotosByLicensePlate(licensePlate)
                };
            }
            connection.Close();
            return citizen;
        }
    }
    private static List<Pictures> GetPhotosByLicensePlate(string licensePlate)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            SELECT * FROM Pictures
            WHERE LicensePlate = @licensePlate
            ";
            cmd.Parameters.AddWithValue("@licensePlate", licensePlate);

            List<Pictures> pictures = new List<Pictures>();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    string photoBase64 = Convert.ToBase64String((byte[])reader["File"]);

                    pictures.Add(
                        new Pictures
                        (
                            reader["FileType"].ToString()!,
                            photoBase64
                        )
                    );
                }
            }
            connection.Close();
            return pictures;
        }
    }
    public static bool CitizenExists(string licensePlate)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = "SELECT LicensePlate FROM Citizens WHERE LicensePlate = @licensePlate";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);

            using (var reader = command.ExecuteReader())
            {
                return reader.Read();
            }
        }
    }
    public static Citizen? AddCitizen(CitizenRequest citizen)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            INSERT INTO Citizens 
            (LicensePlate, VehicleType, VehicleColor, Address, Status, CurrentAddress, 
            ReportedDate, TowedByCraneDate, ArrivalAtParkinglot, ReleaseDate, Lat, Lon,
            ReportedBy, ReleasedBy)
            VALUES 
            (@licensePlate, @vehicleType, @vehicleColor, @address, @status, @currentAddress,
            @reportedDate, @towedByCraneDate, @arrivalAtParkinglot, @releaseDate, @lat, @lon,
            @reportedBy, @releasedBy)
            ";

            DateTime utcNow = DateTime.UtcNow;
            DateTime dominicanNow = utcNow.AddHours(-4);

            cmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            cmd.Parameters.AddWithValue("@vehicleType", citizen.VehicleType);
            cmd.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            cmd.Parameters.AddWithValue("@address", citizen.Address);
            cmd.Parameters.AddWithValue("@status", "Reportado");
            cmd.Parameters.AddWithValue("@currentAddress", citizen.Address);
            cmd.Parameters.AddWithValue("@reportedDate", dominicanNow.ToString("g"));
            cmd.Parameters.AddWithValue("@towedByCraneDate", "");
            cmd.Parameters.AddWithValue("@arrivalAtParkinglot", "");
            cmd.Parameters.AddWithValue("@releaseDate", "");
            cmd.Parameters.AddWithValue("@lat", citizen.Lat);
            cmd.Parameters.AddWithValue("@lon", citizen.Lon);
            cmd.Parameters.AddWithValue("@reportedBy", citizen.ReportedBy);
            cmd.Parameters.AddWithValue("@releasedBy", "");

            cmd.ExecuteNonQuery();

            citizen.Photos.ForEach(picture =>
            {
                var pictureCmd = connection.CreateCommand();
                pictureCmd.CommandText = @"
                INSERT INTO Pictures (LicensePlate, FileType, File)
                VALUES (@licensePlate, @fileType, @file)
                ";
                pictureCmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
                pictureCmd.Parameters.AddWithValue("@fileType", picture.FileType);
                pictureCmd.Parameters.AddWithValue("@file", Convert.FromBase64String(picture.File));

                pictureCmd.ExecuteNonQuery();
            });

            connection.Close();
        }
        return GetByLicensePlate(citizen.LicensePlate);
    }
    public Citizen? UpdateCitizen(Citizen citizen)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            UPDATE Citizens
            SET VehicleType = @vehicleType, VehicleColor = @vehicleColor, Address = @address
            WHERE LicensePlate = @licensePlate
            ";

            command.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            command.Parameters.AddWithValue("@vehicleType", citizen.VehicleType);
            command.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            command.Parameters.AddWithValue("@address", citizen.Address);

            command.ExecuteNonQuery();

            connection.Close();
        }
        return GetByLicensePlate(citizen.LicensePlate);
    }
    public static string DeleteCitizen(string licensePlate)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd1 = connection.CreateCommand();
            var cmd2 = connection.CreateCommand();

            cmd1.CommandText = @"
            DELETE FROM Pictures WHERE LicensePlate = @licensePlate
            ";
            cmd1.Parameters.AddWithValue("@licensePlate", licensePlate);
            cmd1.ExecuteNonQuery();

            cmd2.CommandText = @"
            DELETE FROM Citizens WHERE LicensePlate = @licensePlate
            ";
            cmd2.Parameters.AddWithValue("@licensePlate", licensePlate);
            cmd2.ExecuteNonQuery();

            connection.Close();

            return "Deleted successfully";
        }
    }
    public static void UpdateCitizenStatus(ChangeStatusDTO changeStatusDTO)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            if(changeStatusDTO.NewStatus == "Liberado")
            {
                cmd.CommandText = @"UPDATE Citizens
                              Set Status = @status, ReleasedBy = @releasedBy 
                              WHERE LicensePlate = @licensePlate";
            }
            else
            {
                cmd.CommandText = @"UPDATE Citizens
                              Set Status = @status 
                              WHERE LicensePlate = @licensePlate";
            }
            cmd.Parameters.AddWithValue("@status", changeStatusDTO.NewStatus);
            cmd.Parameters.AddWithValue("@licensePlate", changeStatusDTO.LicensePlate);
            cmd.Parameters.AddWithValue("@releasedBy", changeStatusDTO.Username);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }
    public static void SetDateTime(string licensePlate, string attribute, string newAddress)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @$"UPDATE Citizens
                              SET 
                              {attribute} = @value,
                              CurrentAddress = @currentAddress
                              WHERE 
                              LicensePlate = @licensePlate";
            DateTime utcNow = DateTime.UtcNow;
            DateTime dominicanNow = utcNow.AddHours(-4);
            cmd.Parameters.AddWithValue("@value", dominicanNow.ToString("g"));
            cmd.Parameters.AddWithValue("@currentAddress", newAddress);
            cmd.Parameters.AddWithValue("@licensePlate", licensePlate);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }
}