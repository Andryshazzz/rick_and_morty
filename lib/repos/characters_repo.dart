import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/data/api/api_client.dart';

import '../data/prefs/prefs.dart';
import '../models/characters.dart';

@singleton
class CharacterRepository {
  final ApiClient apiClient;
  final Prefs prefs;

  CharacterRepository({
    required this.apiClient,
    required this.prefs,
  });

  Future<List<Character>> getCharacters(int page) async {
    return apiClient.getCharacters(page);
  }

  Future<Character> getCharactersDetails(int characterId) async {
    return apiClient.getCharactersDetails(characterId);
  }

  Future<bool?> getLikedStatus(int characterId) async {
    return prefs.getLikedStatus(characterId);
  }

  Future<void> setLikedStatus(int characterId, bool isLiked) async {
    return prefs.setLikedStatus(characterId, isLiked);
  }
}
