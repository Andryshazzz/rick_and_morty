abstract class CharactersDetailsEvent {}

class CharactersDetailsLoadData extends CharactersDetailsEvent {
  final int characterId;

  CharactersDetailsLoadData({required this.characterId});
}
