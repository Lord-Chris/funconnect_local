import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/locator.dart';

import 'features/dashboard/presentation/views/home_view.dart';

void main() async {
  setUpLocator();
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
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
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.orange,
            ),
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
            // navigatorKey: NavigationService.navigatorKey,
            // onGenerateRoute: Routes.generateRoute,
            // initialRoute: Routes.initialRoute,
          );
        });
  }
}
