import 'package:funconnect/features/authentication/data/data_sources/http_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/events/data/data_sources/http_events_data_source.dart';
import 'package:funconnect/features/events/data/data_sources/i_events_data_source.dart';
import 'package:funconnect/features/events/data/repositories/events_repository.dart';
import 'package:funconnect/features/events/data/repositories/i_events_repository.dart';
import 'package:funconnect/services/_services.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/repositories/_authentication_repo.dart';

final locator = GetIt.instance;
const bool isMock = false;

Future<void> setUpLocator() async {
  // Services
  locator.registerLazySingleton<INavigationService>(() => NavigationService());
  locator.registerLazySingleton<INetworkService>(() => NetworkService());
  locator.registerLazySingleton<ILocationService>(() => LocationService());
  await _setUpLocalStorage();

  // Repositories
  locator.registerLazySingleton<IAuthenticationRepository>(
    () => isMock ? MockAuthenticationRepository() : AuthenticationRepository(),
  );
  locator.registerLazySingleton<IEventsRepository>(
    () => EventsRepository(),
  );

  // DataSources
  locator.registerLazySingleton<IAuthenticationDataSource>(
    () => HttpAuthenticationDataSource(),
  );
  locator.registerLazySingleton<IEventsDataSource>(
    () => HttpEventsDataSource(),
  );
}

Future<void> _setUpLocalStorage() async {
  locator
      .registerLazySingleton<ILocalStorageService>(() => LocalStorageService());
  await locator<ILocalStorageService>().init();
}
