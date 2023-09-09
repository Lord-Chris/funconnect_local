import 'dart:io';

import 'package:funconnect/features/authentication/data/data_sources/http_authentication_datasource.dart';
import 'package:funconnect/features/authentication/data/data_sources/i_authentication_datasource.dart';
import 'package:funconnect/features/dashboard/data/repository/i_dashboard_repository.dart';
import 'package:funconnect/features/events/data/data_sources/http_events_data_source.dart';
import 'package:funconnect/features/events/data/data_sources/i_events_data_source.dart';
import 'package:funconnect/features/events/data/repositories/events_repository.dart';
import 'package:funconnect/features/events/data/repositories/i_events_repository.dart';
import 'package:funconnect/features/plans/data/repository/i_plans_repository.dart';
import 'package:funconnect/features/plans/data/repository/plans_repository.dart';
import 'package:funconnect/features/profile/data/repository/i_profile_repository.dart';
import 'package:funconnect/features/profile/data/repository/profile_repository.dart';
import 'package:funconnect/features/saved/data/repository/i_saved_repository.dart';
import 'package:funconnect/features/saved/data/repository/saved_repository.dart';
import 'package:funconnect/services/_services.dart';
import 'package:get_it/get_it.dart';

import '../../features/authentication/data/repositories/_authentication_repo.dart';
import '../../features/dashboard/data/repository/dashboard_repository.dart';
import '../../features/places/data/repository/i_place_repository.dart';
import '../../features/places/data/repository/place_repository.dart';

final locator = GetIt.instance;
const bool isMock = false;

Future<void> setUpLocator() async {
  // Services
  locator.registerLazySingleton<INavigationService>(() => NavigationService());
  locator.registerLazySingleton<IDialogAndSheetService>(
      () => DialogAndSheetService());
  locator.registerLazySingleton<INetworkService>(() => NetworkService());
  locator.registerLazySingleton<ILocationService>(
    () => Platform.isIOS ? IosLocationService() : LocationService(),
  );
  locator.registerLazySingleton<IMediaService>(() => MediaService());
  locator
      .registerLazySingleton<IConnectivityService>(() => ConnectivityService());
  locator.registerLazySingleton<IForceUpdateAppService>(
      () => ForceUpdateAppService());

  await _setUpLocalStorage();
  await _setUpDynamicLinkService();
  _setUpNotificationService();

  // Repositories
  locator.registerLazySingleton<IAuthenticationRepository>(
    () => isMock ? MockAuthenticationRepository() : AuthenticationRepository(),
  );
  locator.registerLazySingleton<IDashboardRepository>(
    () => DashboardRepository(),
  );
  locator.registerLazySingleton<IEventsRepository>(
    () => EventsRepository(),
  );
  locator.registerLazySingleton<IPlaceRepository>(
    () => PlaceRepository(),
  );
  locator.registerLazySingleton<ISavedRepository>(
    () => SavedRepository(),
  );
  locator.registerLazySingleton<IProfileRepository>(
    () => ProfileRepository(),
  );
  locator.registerLazySingleton<IPlansRepository>(() => PlansRepository());

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

Future<void> _setUpDynamicLinkService() async {
  locator
      .registerLazySingleton<IDynamicLinkService>(() => DynamicLinkService());
  await locator<IDynamicLinkService>().init();
}

void _setUpNotificationService() {
  locator
      .registerLazySingleton<INotificationService>(() => NotificationService());
  locator<INotificationService>().init();
}
