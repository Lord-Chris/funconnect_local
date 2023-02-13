import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:funconnect/core/app/_app.dart';
import 'package:funconnect/services/_services.dart';
import 'package:funconnect/shared/constants/theme.dart';

void main() async {
  await setUpLocator();
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
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: Routes.generateRoute,
          initialRoute: Routes.dashboardViewRoute,
        );
      }     ,
    );
  }
}
