import 'package:funconnect/features/authentication/data/repositories/authentication_repository.dart';
import 'package:funconnect/features/authentication/data/repositories/i_authentication_repository.dart';
import 'package:funconnect/services/_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<INavigationService>(() => NavigationService());
  locator.registerLazySingleton<INetworkService>(() => NetworkService());
  // locator.registerLazySingleton(() => AppVideoPlayer());

  /// Repos
  locator.registerLazySingleton<IAuthenticationRepository>(
    () => AuthenticationRepository(),
  );
}
