import 'package:dio/dio.dart';

class ApiClient {
  final _dio = Dio();

  ApiClient() {
    _initDio();
  }

  _initDio() async {
    String apiUrl = 'https://rickandmortyapi.com/api';

    _dio.options
      ..baseUrl = apiUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 30);
  }

  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    Duration? receiveTimeout,
  }) async {
    final response = await _dio.get<T>(
      url,
      queryParameters: query,
      options: Options(headers: headers, receiveTimeout: receiveTimeout),
    );

    return response;
  }
}
