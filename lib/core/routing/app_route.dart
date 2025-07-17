import 'package:doctor_appoinment/core/routing/routes.dart';
import 'package:doctor_appoinment/feature/auth/presentation/screens/login_screen.dart';
import 'package:doctor_appoinment/feature/auth/presentation/screens/set_password_screen.dart';
import 'package:doctor_appoinment/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case Routes.setPasswordScreen:
        return MaterialPageRoute(builder: (_) => SetPasswordScreen());
      default:
        return null;
    }
  }
}
