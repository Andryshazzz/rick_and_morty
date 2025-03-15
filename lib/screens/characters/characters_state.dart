import '../../models/characters_details.dart';

class CharactersState {
  final bool isLoading;
  final List<Character> characters;
  final Map<int, bool> likedStatus;

  CharactersState({
    this.isLoading = true,
    this.characters = const [],
    this.likedStatus = const {},
  });

  CharactersState copyWith({
    bool? isLoading,
    List<Character>? characters,
    Map<int, bool>? likedStatus,
  }) {
    return CharactersState(
      isLoading: isLoading ?? this.isLoading,
      characters: characters ?? this.characters,
      likedStatus: likedStatus ?? this.likedStatus,
    );
  }
}
