import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../models/characters.dart';
import 'characters_response.dart';

@singleton
class ApiClient {
  ApiClient() {
    _initDio();
  }

  final _dio = Dio();

  Future<void> _initDio() async {
    const apiUrl = 'https://rickandmortyapi.com/api';

    _dio.options
      ..baseUrl = apiUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 30);
  }

  Future<Character> getCharactersDetails(int characterId) async {
    final request = await _dio.get('/character/$characterId');
    final response = Character.fromJson(request.data);
    return response;
  }

  Future<List<Character>> getCharacters(int page) async {
    final request =
        await _dio.get('/character', queryParameters: {'page': page});
    final response = CharactersResponse.fromJson(request.data).results.toList();
    return response;
  }
}
