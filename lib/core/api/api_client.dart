import 'package:dio/dio.dart';

import '../entities/content_dart_entities.dart';
import 'content.dart';

class ApiClient {
  final dio = Dio();

  Future<List<ContentCardEntities>> getContent() async {
    try {
      final response =
          await dio.get('https://rickandmortyapi.com/api/character');
      final json = response.data as Map<String, dynamic>;
      final data = Content.fromJson(json);
      final content = data.results.map((e) => e.toEntity()).toList();
      return content;
    } catch (e) {
      rethrow;
    }
  }
}
