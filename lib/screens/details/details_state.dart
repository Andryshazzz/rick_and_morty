

import '../../models/characters.dart';

class CharactersDetailsState {
  final bool isLoading;
  final Character? character;

  CharactersDetailsState({
    this.isLoading = true,
    this.character,
  });

  CharactersDetailsState copyWith({
    bool? isLoading,
    Character? character,
  }) {
    return CharactersDetailsState(
      isLoading: isLoading ?? this.isLoading,
      character: character ?? this.character,
    );
  }
}
