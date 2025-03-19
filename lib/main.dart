import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

import 'dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
      ),
      home: CharactersScreen(),
    ),
  );
}
