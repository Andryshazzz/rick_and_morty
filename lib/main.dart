import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/data/api/api_client.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';

import 'app.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('likesBox');
  final apiClient = ApiClient();
  final characterRepository = CharacterRepository(apiClient: apiClient);

  runApp(
    MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF8F8F8)),
      home: RepositoryProvider.value(
        value: characterRepository,
        child: ProviderWidget(),
      ),
    ),
  );
}
