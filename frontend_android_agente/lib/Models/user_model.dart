// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserModel {
  String username;
  String password;
  String role;

  UserModel({
    required this.username,
    required this.password,
    required this.role,
  });
  Map<String, String> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
