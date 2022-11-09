import 'package:flutter/material.dart';
import 'package:funconnect/core/app/locator.dart';

import 'features/startup/presentation/views/onboarding_view.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home: const OnboardingView(),
      // navigatorKey: NavigationService.navigatorKey,
      // onGenerateRoute: Routes.generateRoute,
      // initialRoute: Routes.initialRoute,
    );
  }
}
