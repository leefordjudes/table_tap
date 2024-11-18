library api;

import 'package:get_storage/get_storage.dart';

import 'dio_client/dio_client.dart';

typedef ErrorHandler = Function(List<String>);

class ApiRepository {
  final DioClient client;
  final ErrorHandler errorHandler;
  final GetStorage storage;

  ApiRepository({
    required this.errorHandler,
    required this.storage,
    required baseUrl,
  }) : client = DioClient(baseUrl);

  Future<void> setAuthHeader() async {
    client.setHeader({'token': 'usertoken'});
    print('api setAuthHeader');
  }
}

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
