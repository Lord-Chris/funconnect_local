import 'package:funconnect/features/authentication/data/data_sources/http_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/services/_services.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/repositories/_authentication_repo.dart';

final locator = GetIt.instance;
const bool isMock = true;
void setUpLocator() {
  // Services
  locator.registerLazySingleton<INavigationService>(() => NavigationService());
  locator.registerLazySingleton<INetworkService>(() => NetworkService());

  // Repositories
  locator.registerLazySingleton<IAuthenticationRepository>(
    () => isMock ? MockAuthenticationRepository() : AuthenticationRepository(),
  );

  // DataSources
  locator.registerLazySingleton<IAuthenticationDataSource>(
    () => HttpAuthenticationDataSource(),
  );
}
