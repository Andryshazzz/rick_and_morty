import 'package:rick_and_morty/data/api/api_client.dart';

import '../entities/character.dart';

class CharacterRepository {
  final ApiClient apiClient;

  CharacterRepository({required this.apiClient});

  Future<List<CharacterEntities>> getContent() async {
    return await apiClient.getContent();
  }
}
