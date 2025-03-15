abstract class CharactersEvent {}

class CharactersLoadData extends CharactersEvent {}

class CharactersLikeStatus extends CharactersEvent {
  final int characterId;
  final bool isLiked;

  CharactersLikeStatus({
    required this.characterId,
    required this.isLiked,
  });
}
