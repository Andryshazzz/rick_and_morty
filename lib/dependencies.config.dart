// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rick_and_morty/data/api/api_client.dart' as _i783;
import 'package:rick_and_morty/data/prefs/prefs.dart' as _i582;
import 'package:rick_and_morty/repos/characters_repo.dart' as _i976;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i582.Prefs>(() => _i582.Prefs());
    gh.singleton<_i783.ApiClient>(() => _i783.ApiClient());
    gh.singleton<_i976.CharacterRepository>(
        () => _i976.CharacterRepository(apiClient: gh<_i783.ApiClient>()));
    return this;
  }
}
