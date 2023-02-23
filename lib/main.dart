import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/core/constants/_constants.dart';
import 'package:funconnect/core/utils/failure_handler.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = AppKeys.sentryId;
        options.tracesSampleRate = 1.0;
      },
      appRunner: () async {
        runApp(const MyApp());
      },
    );
  }, (error, stackTrace) async {
    FailureHandler.instance.catchError(error, stackTrace: stackTrace);
  });
}

Future<void> _setupServices() async {
  await setUpLocator();
  await ScreenUtil.ensureScreenSize();
  await FailureHandler.instance.initialize();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        // ScreenUtil.init(context);
        return MaterialApp(
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.initialRoute,
        );
      },
    );
  }
}

// Button on the dialog
// Internet occured icon
