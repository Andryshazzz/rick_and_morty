import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<bool?> getLikedStatus(int characterId) async {
    final prefs = await _prefs;
    return prefs.getBool('liked_$characterId');
  }

  Future<void> setLikedStatus(int characterId, bool isLiked) async {
    final prefs = await _prefs;
    await prefs.setBool('liked_$characterId', isLiked);
  }
}
