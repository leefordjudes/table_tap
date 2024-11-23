import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../custom_exceptions.dart';
import '../api.dart';

part 'request.dart';
part 'response.dart';
part 'user.g.dart';

extension UserRepository on ApiRepository {
  /// Retrieves user's profile information
  Future<UserProfileResponse> getUserProfile(String token) async {
    try {
      final res = await client.get(
        '/bizzUiApi/auth/user/GetUserDetailsByToken.ashx',
        queryParameters: {'token': token},
      );
      if (res.statusCode == 200) {
        print('get user profile response: ${res.data}');
      }
      if (res.statusCode == 404) {
        throw CustomException(res.data['Response']);
      }

      if ((res.data as List<dynamic>).isEmpty) {
        throw CustomException('Bad request');
      }
      final profileRes =
          (res.data as List<dynamic>).first as Map<String, dynamic>;
      if (profileRes['Response'] != 'Success') {
        throw CustomException('Failed to get profile');
      }
      final result = UserLoginResponse.fromJson(profileRes);
      print('UserProfileResponse.fromJson: $result');
      return result.user;
    } on DioException catch (err) {
      // errorHandler.call(['err']);
      debugPrint(err.message);
      throw Exception(err.message ?? 'Internal http exception');
    } catch (err) {
      debugPrint(err.toString());
      throw Exception(err.toString());
    }
  }

  Future<UserLoginResponse> signin(LoginRequest req) async {
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

    if (res.statusCode == 200) {
      print('response: ${res.data}');
    }

    if (res.statusCode == 404) {
      throw CustomException('Resource not found');
    }

    if ((res.data as List<dynamic>).isEmpty) {
      // handlerErrors(['Bad request']);
      throw CustomException('Invalid credential');
    }
    final loginRes = (res.data as List<dynamic>).first as Map<String, dynamic>;
    if (loginRes['Response'] != 'OK') {
      throw CustomException('Login failed');
    }
    final result = UserLoginResponse.fromJson(loginRes);
    return result;
  }

  Future<void> signout() async {
    handlerErrors(['err1', 'err2']);
  }
}
