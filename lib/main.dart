import 'package:flutter/material.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

import 'dependency.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ConfigDependency.configure();

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
      ),
      home: CharactersScreen(),
    ),
  );
}
