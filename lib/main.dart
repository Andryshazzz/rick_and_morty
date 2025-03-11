import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';
import 'package:rick_and_morty/screens/characters/characters_bloc.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('likesBox');
  final dio = Dio();

  final characterRepository = CharacterRepository(dio: dio);
  runApp(BlocProvider(
    create: (context) => HomeBloc(characterRepository: characterRepository),
    child: MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF8F8F8)),
      home: CharactersScreen(),
    ),
  ));
}
