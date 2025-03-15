import '../../models/characters_details.dart';

class CharactersDetailsState {
  final bool isLoading;
  final Character? character;

  CharactersDetailsState({
    this.isLoading = true,
    this.character,
  });

  CharactersDetailsState copyWith({
    bool? isLoadig,
    Character? character,
  }) {
    return CharactersDetailsState(
      isLoading: isLoadig ?? this.isLoading,
      character: character ?? this.character,
    );
  }
}
