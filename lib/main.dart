import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

void main() async {
  runApp(
    MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF8F8F8)),
      home: Provider<CharacterRepository>(
        create: (context) {
          return CharacterRepository();
        },
        child: CharactersScreen(),
      ),
    ),
  );
}
