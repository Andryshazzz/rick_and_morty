import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty/data/api/api_client.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

import 'data/prefs/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.I.registerSingleton(
    CharacterRepository(
      apiClient: ApiClient(),
    ),
  );

  GetIt.I.registerSingleton(
    Prefs(),
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
      ),
      home: CharactersScreen(),
    ),
  );
}
