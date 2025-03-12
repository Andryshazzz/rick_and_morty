import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/characters_details.dart';
import '../../repos/characters_repo.dart';

part 'details_event.dart';

part 'details_state.dart';

class CharactersDetailsBloc
    extends Bloc<CharactersDetailsEvent, CharactersDetailsState> {
  final CharacterRepository repository;

  CharactersDetailsBloc({
    required this.repository,
  }) : super(CharactersDetailsInitial()) {
    on<CharactersDetailsLoadData>(_onLoadCharacterDetails);
  }

  Future<void> _onLoadCharacterDetails(
    CharactersDetailsLoadData event,
    Emitter<CharactersDetailsState> emit,
  ) async {
    final characters = await repository.getCharactersDetails(event.characterId);
    emit(CharactersDetailsLoaded(character: characters));
  }
}
