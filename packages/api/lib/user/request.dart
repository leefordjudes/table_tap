part of './user.dart';

class LoginRequest {
  late String identity;
  late String password;

  LoginRequest({
    required this.identity,
    required this.password,
  });

  LoginRequest.fromJson(Map data) {
    identity = data['identity'];
    password = data['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'identity': identity,
      'password': password,
    };
  }
}
