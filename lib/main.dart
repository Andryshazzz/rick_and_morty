import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/api/api_client.dart';
import 'feature/app.dart';
import 'feature/home/logic/home_bloc.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('likesBox');

  final apiClient = ApiClient();
  runApp(BlocProvider(
    create: (context) => HomeBloc(apiclient: apiClient),
    child: const HomeScreen(),
  ));
}
