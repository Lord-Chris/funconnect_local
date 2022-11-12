import 'package:funconnect/services/_services.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<INavigationService>(() => NavigationService());
  // locator.registerLazySingleton(() => AppVideoPlayer());
}
