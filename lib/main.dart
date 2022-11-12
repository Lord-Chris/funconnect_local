import 'package:flutter/material.dart';
import 'package:funconnect/core/app/locator.dart';
import 'package:funconnect/services/navigation_service/navigation_service.dart';

import 'core/app/routes.dart';

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
      // home: const ProfileSetUpView(),
      navigatorKey: NavigationService.navigatorKey,
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.initialRoute,
    );
  }
}
