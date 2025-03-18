import 'package:rick_and_morty/data/api/api_client.dart';

import '../data/api/characters_response.dart';
import '../models/characters_details.dart';

class CharacterRepository {
  final ApiClient apiClient;

  CharacterRepository({
    required this.apiClient,
  });

  Future<List<Character>> getCharacters() async {
    final request = await apiClient.get('/character');
    final response = CharactersResponse.fromJson(request.data).results.toList();
    return response;
  }

  Future<Character> getCharactersDetails(int characterId) async {
    final request = await apiClient.get('/character/$characterId');
    final response = Character.fromJson(request.data);
    return response;
  }
}
