import 'package:dio/dio.dart';

import '../data/api/content.dart';
import '../entities/character.dart';

class CharacterRepository {
  final Dio dio;

  CharacterRepository({required this.dio});

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
