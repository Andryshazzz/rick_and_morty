import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/dependencies.config.dart';

final getIt = GetIt.I;

@injectableInit
void configureDependencies() {
  getIt.init();
}
