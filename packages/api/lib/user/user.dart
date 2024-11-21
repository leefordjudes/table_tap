import 'dart:convert';

import 'package:api/custom_exceptions.dart';
import 'package:dio/dio.dart';
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
    } on DioException catch (err) {
      debugPrint(err.message);
      throw Exception(err.message ?? 'Internal http exception');
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<UserLoginResponse> login(LoginRequest req) async {
    // final dummy = await client.get('/tamilbible/dummy');
    // print('==>>\n\n${dummy.data}\n\n<<==');
    // final req1 = LoginRequest(
    //   username: 'queenventuread@gmail.com',
    //   password: r'Wkyi$851',
    // );
    final res = await client.get(
      '/bizzUiApi/auth/user/UserLoginHandler.ashx',
      queryParameters: req.toJson(),
    );

    if (res.statusCode == 404) {
      throw CustomException('Resource not found');
    }

    if ((res.data as List<dynamic>).isEmpty) {
      throw CustomException('Bad request');
    }
    final loginRes = (res.data as List<dynamic>).first as Map<String, dynamic>;
    if (loginRes['Response'] != 'OK') {
      throw CustomException('Login failed');
    }
    final result = UserLoginResponse.fromJson(loginRes);
    return result;
  }
}
