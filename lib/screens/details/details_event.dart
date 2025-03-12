part of 'details_bloc.dart';

abstract class CharactersDetailsEvent {}

class CharactersDetailsLoadData extends CharactersDetailsEvent {
  final int characterId;

  CharactersDetailsLoadData({required this.characterId});
}
