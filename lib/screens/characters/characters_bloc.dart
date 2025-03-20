import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/prefs/prefs.dart';
import '../../repos/characters_repo.dart';
import 'characters_event.dart';
import 'characters_state.dart';

@injectable
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final Prefs prefs;
  final CharacterRepository repository;

  CharactersBloc({
    required this.prefs,
    required this.repository,
  }) : super(CharactersState()) {
    on<CharactersLoadData>(_onLoadCharacter);
    on<CharactersLikeStatus>(_onToggleLikeStatus);
  }

  Future<void> _onLoadCharacter(
    CharactersLoadData event,
    Emitter<CharactersState> emit,
  ) async {
    final characters = await repository.getCharacters();
    final likedStatus = <int, bool>{};

    for (var character in characters) {
      likedStatus[character.id] =
          await prefs.getLikedStatus(character.id) ?? false;
    }

    emit(state.copyWith(
      characters: characters,
      isLoading: false,
      likedStatus: likedStatus,
    ));
  }

  Future<void> _onToggleLikeStatus(
    CharactersLikeStatus event,
    Emitter<CharactersState> emit,
  ) async {
    await prefs.setLikedStatus(event.characterId, event.isLiked);
    final toggleLike = Map<int, bool>.from(state.likedStatus);
    toggleLike[event.characterId] = event.isLiked;

    emit(state.copyWith(
      likedStatus: toggleLike,
    ));
  }
}
