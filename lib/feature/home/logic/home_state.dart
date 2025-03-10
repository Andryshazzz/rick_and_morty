part of 'home_bloc.dart';

abstract class HomeState {}

class Initial extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<ContentCardEntities> content;

  Loaded({required this.content});
}

class Error extends HomeState {}
