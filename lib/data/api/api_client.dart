import 'package:dio/dio.dart';
import '../../entities/character.dart';
import 'content.dart';

class ApiClient {
  final Dio dio = Dio();

  Future<List<CharacterEntities>> getContent() async {
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
