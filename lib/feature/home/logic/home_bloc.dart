import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/api/api_client.dart';
import '../../../core/entities/content_dart_entities.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiClient _apiClient;

  HomeBloc({required ApiClient apiclient})
      : _apiClient = apiclient,
        super(Initial()) {
    on<LoadData>(_onLoadAnime);
  }

  Future<void> _onLoadAnime(
    LoadData event,
    Emitter<HomeState> emit,
  ) async {
    final content = await _apiClient.getContent();
    emit(Loaded(content: content));
  }
}
