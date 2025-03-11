import 'package:dio/dio.dart';
import '../../entities/character.dart';
import 'content.dart';

abstract class ApiClient {
  Future<List<CharacterEntities>> getContent();
}
