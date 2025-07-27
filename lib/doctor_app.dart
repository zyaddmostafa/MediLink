import 'core/routing/app_route.dart';
import 'core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_theme.dart';

class DoctorApp extends StatelessWidget {
  const DoctorApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        // initialRoute: isLoggedInUser ? Routes.homeScreen : Routes.loginScreen,
        initialRoute: Routes.mainNavigation,
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
