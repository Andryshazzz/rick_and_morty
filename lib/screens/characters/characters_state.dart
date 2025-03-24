import '../../models/characters.dart';

class CharactersState {
  final bool isLoading;
  final bool isLoadingMore;
  final List<Character> characters;
  final Map<int, bool> likedStatus;
  final int currentPage;

  CharactersState({
    this.currentPage = 0,
    this.isLoadingMore = false,
    this.isLoading = true,
    this.characters = const [],
    this.likedStatus = const {},
  });

  CharactersState copyWith({
    int? currentPage,
    bool? isLoading,
    bool? isLoadingMore,
    List<Character>? characters,
    Map<int, bool>? likedStatus,
  }) {
    return CharactersState(
      currentPage: currentPage ?? this.currentPage,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      characters: characters ?? this.characters,
      likedStatus: likedStatus ?? this.likedStatus,
    );
  }
}
