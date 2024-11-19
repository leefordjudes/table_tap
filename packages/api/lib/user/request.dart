part of './user.dart';

class LoginRequest {
  late String username;
  late String password;

  LoginRequest({
    required this.username,
    required this.password,
  });

  LoginRequest.fromJson(Map data) {
    username = data['username'];
    password = data['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
