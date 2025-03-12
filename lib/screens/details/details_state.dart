part of 'details_bloc.dart';

abstract class CharactersDetailsState {}

class CharactersDetailsInitial extends CharactersDetailsState {}

class CharactersDetailsLoading extends CharactersDetailsState {}

class CharactersDetailsLoaded extends CharactersDetailsState {
  final Character character;

  CharactersDetailsLoaded({required this.character});
}

class CharactersDetailsError extends CharactersDetailsState {}
