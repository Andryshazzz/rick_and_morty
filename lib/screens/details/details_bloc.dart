import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../repos/characters_repo.dart';
import 'details_event.dart';
import 'details_state.dart';

@injectable
class CharactersDetailsBloc
    extends Bloc<CharactersDetailsEvent, CharactersDetailsState> {
  final CharacterRepository repository;
  final int characterId;

  CharactersDetailsBloc({
    required this.repository,
    @factoryParam required this.characterId,
  }) : super(CharactersDetailsState()) {
    on<CharactersDetailsLoadData>(_onLoadCharacterDetails);
  }

  Future<void> _onLoadCharacterDetails(
    CharactersDetailsLoadData event,
    Emitter<CharactersDetailsState> emit,
  ) async {
    final character = await repository.getCharactersDetails(characterId);
    emit(state.copyWith(
      character: character,
      isLoading: false,
    ));
  }
}
