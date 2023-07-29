import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/blocs/main_app_bloc.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/features/authentication/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:funconnect/features/authentication/presentation/welcome/welcome_view.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:funconnect/features/dashboard/presentation/dashboard/dashboard_view.dart';
import 'package:funconnect/features/startup/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:funconnect/features/startup/presentation/splash/bloc/splash_bloc.dart';
import 'package:funconnect/features/startup/presentation/onboarding/onboarding_view.dart';
import 'package:funconnect/features/startup/presentation/version_update/version_update_view.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/_constants.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'features/startup/presentation/splash/bloc/splash_event.dart';
import 'features/startup/presentation/splash/bloc/splash_state.dart';
import 'firebase_options.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    FlutterError.onError = (details) async {
      if (kDebugMode) {
        FlutterError.dumpErrorToConsole(details);
      } else {
        Zone.current.handleUncaughtError(details.exception, details.stack!);
      }
    };

    await _setupServices();

    runApp(const SentryScreenshotWidget(child: MyApp()));
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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => SplashBloc(),
      child: ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          context.read<SplashBloc>().add(InitializeSplashEvent());
          return BlocProvider(
            create: (context) => MainAppBloc(),
            child: MaterialApp(
              theme: AppTheme.theme,
              title: AppConstants.appName,
              debugShowCheckedModeBanner: false,
              navigatorKey: NavigationService.navigatorKey,
              onGenerateRoute: Routes.generateRoute,
              home: BlocBuilder<SplashBloc, SplashState>(
                buildWhen: (previous, current) =>
                    previous is SplashInitialState,
                builder: (context, state) {
                  if (state is SplashFinishedState) {
                    FlutterNativeSplash.remove();
                    if (state.needsUpdate == true) {
                      return const VersionUpdateView();
                    }
                    if (state.isAuthenticated) {
                      return BlocProvider(
                        create: (context) => DashboardBloc(),
                        child: const DashboardView(),
                      );
                    } else {
                      if (state.showOnboarding) {
                        return BlocProvider(
                          create: (context) => OnboardingBloc(),
                          child: const OnboardingView(),
                        );
                      } else {
                        return BlocProvider(
                          create: (context) => WelcomeBloc(),
                          child: const WelcomeView(),
                        );
                      }
                    }
                  }
                  return Scaffold(
                    body: Container(
                      width: double.maxFinite,
                      color: AppColors.mediumBlack,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 250.r,
                            width: 250.r,
                            child: SvgPicture.asset(
                              AppAssets.funconnectFullSvg,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Button on the dialog
// Internet occurred icon
// Filter flow
// iOS tags
