import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/repos/characters_repo.dart';
import 'package:rick_and_morty/screens/characters/characters_bloc.dart';
import 'package:rick_and_morty/screens/characters/characters_screen.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = RepositoryProvider.of<CharacterRepository>(context);
    return BlocProvider(
      create: (context) => HomeBloc(repository: repo),
      child: CharactersScreen(),
    );
  }
}
