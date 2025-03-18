import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../repos/characters_repo.dart';
import 'details_event.dart';
import 'details_state.dart';

class CharactersDetailsBloc
    extends Bloc<CharactersDetailsEvent, CharactersDetailsState> {
  CharactersDetailsBloc() : super(CharactersDetailsState()) {
    on<CharactersDetailsLoadData>(_onLoadCharacterDetails);
  }

  Future<void> _onLoadCharacterDetails(
    CharactersDetailsLoadData event,
    Emitter<CharactersDetailsState> emit,
  ) async {
    final character = await GetIt.I<CharacterRepository>()
        .getCharactersDetails(event.characterId);
    emit(state.copyWith(
      character: character,
      isLoadig: false,
    ));
  }
}
