import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../repos/characters_repo.dart';
import 'characters_event.dart';
import 'characters_state.dart';

@injectable
class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharacterRepository repository;

  CharactersBloc({
    required this.repository,
  }) : super(CharactersState()) {
    on<CharactersLoadData>(_onLoadCharacter);
    on<CharactersLoadMoreData>(_onLoadMoreCharacter);
    on<CharactersLikeStatus>(_onToggleLikeStatus);
  }

  Future<void> _onLoadCharacter(
    CharactersLoadData event,
    Emitter<CharactersState> emit,
  ) async {
    final characters = await repository.getCharacters(state.currentPage);
    final likedStatus = <int, bool>{};

    for (final character in characters) {
      likedStatus[character.id] =
          await repository.getLikedStatus(character.id) ?? false;
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
    await repository.setLikedStatus(event.characterId, event.isLiked);
    final toggleLike = Map<int, bool>.from(state.likedStatus);
    toggleLike[event.characterId] = event.isLiked;

    emit(state.copyWith(
      likedStatus: toggleLike,
    ));
  }

  Future<void> _onLoadMoreCharacter(
    CharactersLoadMoreData event,
    Emitter<CharactersState> emit,
  ) async {
    emit(state.copyWith(isLoadingMore: true));

    final currentPage = state.currentPage + 1;
    final pageCharacters = await repository.getCharacters(currentPage + 1);

    final likedStatus = <int, bool>{};
    for (final character in pageCharacters) {
      likedStatus[character.id] =
          await repository.getLikedStatus(character.id) ?? false;
    }

    emit(
      state.copyWith(
        currentPage: currentPage,
        isLoadingMore: false,
        characters: [...state.characters, ...pageCharacters],
        likedStatus: {...state.likedStatus, ...likedStatus},
      ),
    );
  }
}
