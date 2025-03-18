import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/api/api_client.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';

import 'data/prefs/prefs.dart';

class ConfigDependency {
  static void configure() {
    final getIt = GetIt.I;

    getIt.registerSingleton(
      CharacterRepository(
        apiClient: ApiClient(),
      ),
    );

    getIt.registerSingleton(
      Prefs(),
    );
  }
}
