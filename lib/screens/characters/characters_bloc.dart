import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repos/characters_repo.dart';
import 'characters_event.dart';
import 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;

  CharactersBloc({
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final likedStatus = <int, bool>{};

    for (var character in characters) {
      likedStatus[character.id] =
          prefs.getBool('liked_${character.id}') ?? false;
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('liked_${event.characterId}', event.isLiked);

    final toggleLike = Map<int, bool>.from(state.likedStatus);
    toggleLike[event.characterId] = event.isLiked;

    emit(state.copyWith(
      likedStatus: toggleLike,
    ));
  }
}
