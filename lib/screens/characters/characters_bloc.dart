import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';

part 'characters_event.dart';

part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;

  CharactersBloc({
    required this.repository,
  }) : super(CharactersInitial()) {
    on<CharactersLoadData>(_onLoadCharacter);
  }

  Future<void> _onLoadCharacter(
      CharactersLoadData event,
    Emitter<CharactersState> emit,
  ) async {
    final characters = await repository.getCharacters();
    emit(CharactersLoaded(character: characters));
  }
}
