import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../api.dart';

part 'request.dart';
part 'response.dart';
part 'user.g.dart';

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
        'mobile': '9876543210',
      };
      final result = UserProfileResponse.fromJson(data);
      print('UserProfileResponse.fromJson: $result');
      return result;
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<UserProfileResponse> login(LoginRequest req) async {
    try {
      final res = await client.get(
        '/bizzUiApi/auth/user/UserLoginHandler.ashx',
        queryParameters: req.toJson(),
      );
      final loginRes = jsonDecode(res.data);
      if (loginRes['Response'] != 'OK') {
        throw Exception('Login failed');
      }
      final result = UserProfileResponse.fromJson(loginRes['UserDetails']);
      print('UserProfileResponse.fromJson: $result');
      return result;
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err.toString());
    }
  }
}
