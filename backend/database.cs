using Microsoft.Data.Sqlite;
using Models;

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
                Lat VARCHAR(60),
                Lon VARCHAR(60),
            )";
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
            CREATE TABLE IF NOT EXISTS Agents (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                GovernmentID VARCHAR(50) UNIQUE,
                Password VARCHAR(255)
            )";
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Admins (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                GovernmentID VARCHAR(50) UNIQUE,
                Password VARCHAR(255)
            )";
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
                    string photoBase64 = Convert.ToBase64String((byte[])reader["File"]);

                    citizens.Add(
                        new Citizen
                        {
                            LicensePlate = reader["LicensePlate"].ToString()!,
                            VehicleType = reader["VehicleType"].ToString()!,
                            Address = reader["Address"].ToString()!,
                            VehicleColor = reader["VehicleColor"].ToString()!,
                            Status = reader["Status"].ToString()!,
                            Lat = reader["Lat"].ToString()!,
                            Lon = reader["Lon"].ToString()!,
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
                    Lat = reader["Lat"].ToString()!,
                    Lon = reader["Lon"].ToString()!,
                    Photos = GetPhotosByLicensePlate(licensePlate),
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
                            reader["LicensePlate"].ToString()!,
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

    public Citizen? AddCitizen(Citizen citizen)
    {

        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            INSERT INTO Citizens (LicensePlate, VehicleType, VehicleColor, Address, Status, Lat, Lon)
            VALUES (@licensePlate, @vehicleType, @vehicleColor, @address, @status, @lat, @lon, @file)
            ";

            cmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            cmd.Parameters.AddWithValue("@vehicleType", citizen.VehicleType);
            cmd.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            cmd.Parameters.AddWithValue("@address", citizen.Address);
            cmd.Parameters.AddWithValue("@status", "Reportado");
            cmd.Parameters.AddWithValue("@lat", citizen.Lat);
            cmd.Parameters.AddWithValue("@lon", citizen.Lon);

            cmd.ExecuteNonQuery();

            cmd.CommandText = @"
            INSERT INTO Pictures (LicensePlate, FileType, File)
            VALUES (@licensePlate, @fileType, @file)
            ";

            citizen.Photos.ForEach( picture =>
            {
                cmd.Parameters.AddWithValue("@licensePlate", picture.LicensePlate);
                cmd.Parameters.AddWithValue("@fileType", picture.FileType);
                cmd.Parameters.AddWithValue("@file", Convert.FromBase64String(picture.File));

                cmd.ExecuteNonQuery();
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
            SET VehicleType = @vehicleType, VehicleColor = @vehicleColor, Address = @address, Status = @status, Lat = @lat, Lon = @lon
            WHERE LicensePlate = @licensePlate
            ";

            command.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            command.Parameters.AddWithValue("@vehicleType", citizen.VehicleType);
            command.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            command.Parameters.AddWithValue("@address", citizen.Address);
            command.Parameters.AddWithValue("@status", citizen.Status);
            command.Parameters.AddWithValue("@lat", citizen.Lat);
            command.Parameters.AddWithValue("@lon", citizen.Lon);

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

            var command = connection.CreateCommand();

            command.CommandText = @"
            DELETE FROM Citizens WHERE LicensePlate = @licensePlate
            DELETE FROM Pictures WHERE LicensePlate = @licensePlate
            ";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);
            command.ExecuteNonQuery();

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
            cmd.CommandText = @"UPDATE Citizens
                              Set Status = @status
                              WHERE LicensePlate = @licensePlate";
            cmd.Parameters.AddWithValue("@status", changeStatusDTO.NewStatus);
            cmd.Parameters.AddWithValue("@licensePlate", changeStatusDTO.LicensePlate);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }
    
    // Agents
    public static List<User> GetAllAgents()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"SELECT * FROM Agents";

            List<User> users = new List<User>();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    users.Add(new User
                        (
                            reader["GovernmentID"].ToString()!,
                            reader["Password"].ToString()!
                        ));
                }
            }
            connection.Close();
            return users;
        }
    }
    public static bool IsValidAgent(string governmentID, string password)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = "SELECT Password FROM Agents WHERE Username = @username";
            command.Parameters.AddWithValue("@username", governmentID);

            using (var reader = command.ExecuteReader())
            {
                if (reader.Read())
                {
                    string? passwordFromDb = reader["PasswordHash"].ToString();
                    return password == passwordFromDb;
                }
            }
        }
        return false;
    }
    public static User? GetAgentByGovernmentID(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            User? user = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"SELECT * FROM Agents WHERE GovernmentID = @governmentID";
            command.Parameters.AddWithValue("@governmentID", governmentID);

            var reader = command.ExecuteReader();

            if (reader.Read())
            {
                user = new User(reader["GovernmentID"].ToString()!, reader["Password"].ToString()!);
            }
            connection.Close();
            return user;
        }
    }
    public static User? AddAgent(User user)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            INSERT INTO Agents (GovernmentID, Password)
            VALUES (@GovernmentID, @Password)
            ";

            cmd.Parameters.AddWithValue("@GovernmentID", user.GovernmentID);
            cmd.Parameters.AddWithValue("@Password", user.Password);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
        return GetAgentByGovernmentID(user.GovernmentID);
    }
    public static User? ChangeAgentPassword(User user)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            UPDATE Agents
            SET Password = @password
            WHERE GovernmentID = @governmentID
            ";

            command.Parameters.AddWithValue("@governmentID", user.GovernmentID);
            command.Parameters.AddWithValue("@password", user.Password);

            command.ExecuteNonQuery();

            connection.Close();
        }
        return GetAgentByGovernmentID(user.GovernmentID);
    }
    public static void DeleteAgent(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            DELETE FROM Agents WHERE GovernmentID = @governmentID
            ";
            command.Parameters.AddWithValue("@governmentID", governmentID);
            command.ExecuteNonQuery();

            connection.Close();
        }
    }
    // Admins
    public static List<User> GetAllAdmins()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"SELECT * FROM Admin";

            List<User> users = new List<User>();

            using (var reader = cmd.ExecuteReader())
            {
                while (reader.Read())
                {
                    users.Add(new User
                        (
                            reader["GovernmentID"].ToString()!,
                            reader["Password"].ToString()!
                        ));
                }
            }
            connection.Close();
            return users;
        }
    }
    public static User? GetAdminByGovernmentID(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            User? user = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"SELECT * FROM Admins WHERE GovernmentID = @governmentID";
            command.Parameters.AddWithValue("@governmentID", governmentID);

            var reader = command.ExecuteReader();

            if (reader.Read())
            {
                user = new User(reader["GovernmentID"].ToString()!, reader["Password"].ToString()!);
            }

            connection.Close();
            return user;
        }
    }
    public static User? AddAdmin(User user)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            INSERT INTO Admins (GovernmentID, Password)
            VALUES (@GovernmentID, @Password)
            ";

            cmd.Parameters.AddWithValue("@GovernmentID", user.GovernmentID);
            cmd.Parameters.AddWithValue("@Password", user.Password);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
        return GetAgentByGovernmentID(user.GovernmentID);
    }
    public static void DeleteAdmin(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            DELETE FROM Admins WHERE GovernmentID = @governmentID
            ";
            command.Parameters.AddWithValue("@governmentID", governmentID);
            command.ExecuteNonQuery();

            connection.Close();
        }
    }
}