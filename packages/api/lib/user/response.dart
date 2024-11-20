part of './user.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class UserProfileResponse {
  late int id;
  late String name;
  late String email;
  late String mobile;

  UserProfileResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
  });

  factory UserProfileResponse.fromJson(Map<String, Object?> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}

class UserLoginResponse {
  late String token;
  late UserProfileResponse user;

  UserLoginResponse({
    required this.token,
    required this.user,
  });

  UserLoginResponse.fromJson(Map data) {
    token = data['Token'];
    user = UserProfileResponse.fromJson(data['UserDetails']);
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }
}
