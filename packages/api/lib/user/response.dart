part of './user.dart';

class UserProfileResponse {
  late String id;
  late String email;
  late String name;
  late String mobileNo;
  late bool verificationStatus;

  UserProfileResponse.fromJson(Map data) {
    id = data['id'];
    email = data['email'];
    name = data['name'];
    mobileNo = data['mobileNo'];
    verificationStatus = data['verificationStatus'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'mobileNo': mobileNo,
      'verificationStatus': verificationStatus,
    };
  }
}

class UserLoginResponse {
  late String token;
  late UserProfileResponse user;

  UserLoginResponse.fromJson(Map data) {
    token = data['token'];
    user = UserProfileResponse.fromJson(data['user']);
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}
