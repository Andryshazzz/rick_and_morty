import 'package:flutter_bloc/flutter_bloc.dart';
import '../../entities/character.dart';
import '../../data/api/api_client.dart';
import '../../repos/characters_repo.dart';

part 'characters_event.dart';

part 'characters_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CharacterRepository repository;

  HomeBloc({
    required this.repository,
  }) : super(Initial()) {
    on<LoadData>(_onLoadAnime);
  }

  Future<void> _onLoadAnime(
    LoadData event,
    Emitter<HomeState> emit,
  ) async {
    final content = await repository.getContent();
    emit(Loaded(content: content));
  }
}
