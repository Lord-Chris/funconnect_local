import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/hive_keys.dart';
import 'package:funconnect/core/constants/storage_keys.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/features/authentication/presentation/blocs/welcome_bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/views/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/blocs/dashboard_bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:funconnect/features/startup/presentation/blocs/onboarding_bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/views/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/views/version_update_view.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';

import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    FlutterError.onError = (details) async {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    await _setupServices();
    runApp(MyApp());
  }, (error, stackTrace) async {
    FailureHandler.instance.catchError(error, stackTrace: stackTrace);
  });
}

Future<void> _setupServices() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setUpLocator();
  await ScreenUtil.ensureScreenSize();
  await FailureHandler.instance.initialize();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _localStorageService = locator<ILocalStorageService>();
  final _forceUpdateAppService = locator<IForceUpdateAppService>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return MaterialApp(
          theme: AppTheme.theme,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: Routes.generateRoute,
          home: FutureBuilder(
              future: _forceUpdateAppService.needsUpdate,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  FlutterNativeSplash.remove();
                  if (snapshot.hasData) {
                    if (snapshot.data == true) {
                      return const VersionUpdateView();
                    }
                    if (isAuthenticated) {
                      return BlocProvider(
                        create: (context) => DashboardBloc(),
                        child: const DashboardView(),
                      );
                    } else {
                      if (showOnboarding) {
                        return BlocProvider(
                          create: (context) => OnboardingBloc(),
                          child: const OnboardingView(),
                        );
                      } else {
                        return BlocProvider(
                            create: (context) => WelcomeBloc(),
                            child: const WelcomeView());
                      }
                    }
                  }
                }
                return const Center(
                  child: Text(" No Page Defined"),
                );
              }),
        );
      },
    );
  }

  bool get showOnboarding => _localStorageService.read(HiveKeys.appBoxId,
      key: StorageKeys.showOnboarding, def: true);

  bool get isAuthenticated => _localStorageService
      .read(HiveKeys.userBoxId, key: StorageKeys.token, def: "")
      .isNotEmpty;
}

// Button on the dialog
// Internet occured icon
// Filter flow
// iOS tags
