import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/auth/presentation/cubit/login_cubit/login_cubit.dart';
import '../../feature/auth/presentation/cubit/signup/signup_cubit.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';
import '../../feature/auth/presentation/screens/login_screen.dart';
import '../../feature/auth/presentation/screens/set_password_screen.dart';
import '../../feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.setPasswordScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<SignupCubit>(),
            child: SetPasswordScreen(gender: args as int),
          ),
        );
      default:
        return null;
    }
  }
}
