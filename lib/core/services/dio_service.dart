import 'package:dio/dio.dart';

class DioService {
  static Dio? _dio;
  static final DioService dio = DioService._();

  DioService._();

  Future<Dio> get dioService async {
    if (_dio != null) {
      return _dio!;
    }

    _dio = await initDio();

    return _dio!;
  }

  Future<Dio> initDio() async {
    // Initialize options to configure dio
    BaseOptions options = BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com/',
      receiveDataWhenStatusError: true,
      headers: {
        'Content-type': 'application/json'
      },
    );

    _dio = Dio(options);
    return _dio!;
  }
}