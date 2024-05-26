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
                Description VARCHAR(100),
                Address VARCHAR(100),
                VehicleColor VARCHAR(20),
                Status VARCHAR(20),
                Lat VARCHAR(60),
                Lon VARCHAR(60),
                File BLOB,
                FileType VARCHAR(40)
            )";
            command.ExecuteNonQuery();

            command.CommandText = @"
            CREATE TABLE IF NOT EXISTS Users (
                Id INTEGER PRIMARY KEY AUTOINCREMENT,
                GovernmentID VARCHAR(50) UNIQUE,
                Password VARCHAR(255)
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
                            Description = reader["Description"].ToString()!,
                            Address = reader["Address"].ToString()!,
                            VehicleColor = reader["VehicleColor"].ToString()!,
                            Status = reader["Status"].ToString()!,
                            Lat = reader["Lat"].ToString()!,
                            Lon = reader["Lon"].ToString()!,
                            File = photoBase64,
                            FileType = reader["FileType"].ToString()!
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
                string photoBase64 = Convert.ToBase64String((byte[])reader["File"]);

                citizen = new Citizen
                {

                    LicensePlate = reader["LicensePlate"].ToString()!,
                    Description = reader["Description"].ToString()!,
                    Address = reader["Address"].ToString()!,
                    VehicleColor = reader["VehicleColor"].ToString()!,
                    Status = reader["Status"].ToString()!,
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
                if (reader.Read())
                {
                    return true;
                }
                return false;
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
            INSERT INTO Citizens (LicensePlate, Description, Address, VehicleColor, Status, Lat, Lon, File, FileType)
            VALUES (@licensePlate, @description, @address, @vehicleColor, @status, @lat, @lon, @file, @fileType)
            ";

            byte[] photoBytes = Convert.FromBase64String(citizen.File!);

            cmd.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            cmd.Parameters.AddWithValue("@description", citizen.Description);
            cmd.Parameters.AddWithValue("@address", citizen.Address);
            cmd.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            cmd.Parameters.AddWithValue("@status", "INCAUTADO");
            cmd.Parameters.AddWithValue("@lat", citizen.Lat);
            cmd.Parameters.AddWithValue("@lon", citizen.Lon);
            cmd.Parameters.AddWithValue("@file", photoBytes);
            cmd.Parameters.AddWithValue("@fileType", citizen.FileType);


            cmd.ExecuteNonQuery();

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
            SET Description = @description, Address = @address, VehicleColor = @vehicleColor, Status = @status, Lat = @lat, Lon = @lon, File = @file, FileType = @fileType
            WHERE LicensePlate = @licensePlate
            ";

            byte[] photoBytes = Convert.FromBase64String(citizen.File!);

            command.Parameters.AddWithValue("@licensePlate", citizen.LicensePlate);
            command.Parameters.AddWithValue("@description", citizen.Description);
            command.Parameters.AddWithValue("@address", citizen.Address);
            command.Parameters.AddWithValue("@vehicleColor", citizen.VehicleColor);
            command.Parameters.AddWithValue("@status", citizen.Status);
            command.Parameters.AddWithValue("@lat", citizen.Lat);
            command.Parameters.AddWithValue("@lon", citizen.Lon);
            command.Parameters.AddWithValue("@file", photoBytes);
            command.Parameters.AddWithValue("fileType", citizen.FileType);

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
            ";
            command.Parameters.AddWithValue("@licensePlate", licensePlate);
            command.ExecuteNonQuery();

            connection.Close();

            return "Deleted successfully";
        }
    }
    public static void UpdateCitizenStatusToP(string licensePlate)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"UPDATE Citizens
                              Set Status = @status
                              WHERE LicensePlate = @licensePlate";
            cmd.Parameters.AddWithValue("@status", "EN PARQUEADERO");
            cmd.Parameters.AddWithValue("@licensePlate", licensePlate);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }
    public static void UpdateCitizenStatusToI(string licensePlate)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"UPDATE Citizens
                              Set Status = @status
                              WHERE LicensePlate = @licensePlate";
            cmd.Parameters.AddWithValue("@status", "INCAUTADO");
            cmd.Parameters.AddWithValue("@licensePlate", licensePlate);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
    }

    public static List<User> GetAllUsers()
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"SELECT * FROM Users";

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
    public static bool IsValidUser(string governmentID, string password)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = "SELECT Password FROM Users WHERE Username = @username";
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
    public static User? GetUserByGovernmentID(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            User? user = null;
            connection.Open();
            var command = connection.CreateCommand();
            command.CommandText = @"SELECT * FROM Users WHERE GovernmentID = @governmentID";
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
    public static User? AddUser(User user)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var cmd = connection.CreateCommand();
            cmd.CommandText = @"
            INSERT INTO Users (GovernmentID, Password)
            VALUES (@GovernmentID, @Password)
            ";

            cmd.Parameters.AddWithValue("@GovernmentID", user.GovernmentID);
            cmd.Parameters.AddWithValue("@Password", user.Password);

            cmd.ExecuteNonQuery();

            connection.Close();
        }
        return GetUserByGovernmentID(user.GovernmentID);
    }
    public static User? ChangeUserPassword(User user)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            UPDATE Users
            SET Password = @password
            WHERE GovernmentID = @governmentID
            ";

            command.Parameters.AddWithValue("@governmentID", user.GovernmentID);
            command.Parameters.AddWithValue("@password", user.Password);

            command.ExecuteNonQuery();

            connection.Close();
        }
        return GetUserByGovernmentID(user.GovernmentID);
    }
    public static void DeleteUser(string governmentID)
    {
        using (var connection = new SqliteConnection(connectionString))
        {
            connection.Open();

            var command = connection.CreateCommand();
            command.CommandText = @"
            DELETE FROM Users WHERE GovernmentID = @governmentID
            ";
            command.Parameters.AddWithValue("@governmentID", governmentID);
            command.ExecuteNonQuery();

            connection.Close();
        }
    }
}