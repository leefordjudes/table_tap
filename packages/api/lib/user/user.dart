import '../api.dart';

part 'request.dart';
part 'response.dart';

extension UserRepository on ApiRepository {
  /// Retrieves user's profile information
  Future<UserProfileResponse> getUserProfile() async {
    try {
      final res = await client.get('/users/1');
      print('get user profile response: ${res.data}');
      final data = {
        'id': '1',
        'email': 'user@sample.com',
        'name': 'testuser',
        'mobileNo': '9876543210',
        'verificationStatus': true,
      };
      final result = UserProfileResponse.fromJson(data);
      print('UserProfileResponse.fromJson: $result');
      return result;
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
