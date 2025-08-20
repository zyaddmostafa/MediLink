import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/auth/presentation/cubit/auth_cubit.dart';
import '../../feature/booking/presentation/screen/booking_screen.dart';
import '../../feature/checkout/data/model/appointment_details_model.dart';
import '../../feature/booking/presentation/cubit/booking_appointment_cubit.dart';
import '../../feature/checkout/presentation/cubit/payment_checkout_cubit.dart';
import '../../feature/checkout/presentation/screens/appointment_detail_screen.dart';
import '../../feature/checkout/presentation/screens/payment_methods_screen.dart';
import '../../feature/home/data/model/category_model.dart';
import '../../feature/home/data/model/doctor_model.dart';
import '../../feature/home/presentation/cubit/home_cubit.dart';
import '../../feature/home/presentation/screens/doctor_info_screen.dart';
import '../../feature/home/presentation/screens/doctors_by_category_screen.dart';
import '../../feature/home/presentation/screens/favorite_screen.dart';
import '../../feature/home/presentation/screens/notification_screen.dart';
import '../../feature/home/presentation/screens/search_screen.dart';
import '../../feature/home/presentation/screens/home_screen.dart';
import '../../feature/home/presentation/screens/see_all_categories_screen.dart';
import '../../feature/home/presentation/screens/see_all_doctors_screen.dart';
import '../../feature/navigation/main_navigation.dart';
import '../../feature/profile/presentation/cubit/user_cubit.dart';
import '../../feature/profile/presentation/screens/edit_profile_screen.dart';
import '../di/dependency_injection.dart';
import '../paymob/paymob_card_getway.dart';
import '../paymob/paymob_mobile_getway.dart';
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
            create: (context) => getIt<AuthCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.setPasswordScreen:
        final Map<String, dynamic> signupData = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<AuthCubit>(),
            child: SetPasswordScreen(signupData: signupData),
          ),
        );

      case Routes.mainNavigation:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UserCubit(getIt()),
            child: const MainNavigation(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: const HomeScreen(),
          ),
        );

      case Routes.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<HomeCubit>(),
            child: const SearchScreen(),
          ), // Assuming SearchScreen is defined
        );
      case Routes.favoriteScreen:
        return MaterialPageRoute(
          builder: (_) =>
              const FavoriteScreen(), // Assuming FavoriteScreen is defined
        );

      case Routes.seeAllDoctors:
        final List<DoctorModel>? doctors = args as List<DoctorModel>?;
        return MaterialPageRoute(
          builder: (_) => SeeAllDoctorsScreen(doctors: doctors),
        );

      case Routes.doctorsByCategory:
        final CategoryModel categoryModel = args as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                getIt<HomeCubit>()..getDoctorsByCategory(categoryModel.id),
            child: DoctorsByCategoriesScreen(categoryModel: categoryModel),
          ),
        );

      case Routes.seeAllCategory:
        return MaterialPageRoute(
          builder: (_) =>
              const SeeAllCategoriesScreen(), // Assuming SeeAllCategory is defined
        );

      case Routes.doctorInfo:
        final int doctorId = args as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<HomeCubit>()..getDoctorById(doctorId),
            child: const DoctorInfoScreen(),
          ),
        );

      case Routes.appointmentDetailsScreen:
        final AppointmentDetailsModel appointmentDetails =
            args as AppointmentDetailsModel;
        return MaterialPageRoute(
          builder: (_) =>
              AppointmentDetailsScreen(appointmentDetails: appointmentDetails),
        );
      case Routes.appointmentPaymentMethodsScreen:
        final AppointmentDetailsModel appointmentDetails =
            args as AppointmentDetailsModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: getIt<BookingAppointmentCubit>()),
              BlocProvider(create: (_) => getIt<PaymentCheckoutCubit>()),
            ],
            child: PaymentMethodsScreen(appointmentDetails: appointmentDetails),
          ),
        );

      case Routes.cardPaymentGetWay:
        final Map<String, dynamic> paymentData = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<BookingAppointmentCubit>(),
            child: PaymobCardGetway(
              paymentToken: paymentData['paymentToken'],
              appointmentDetails: paymentData['appointmentDetails'],
            ),
          ),
        );

      case Routes.paymobMobileGetway:
        final Map<String, dynamic> mobileData = args as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<BookingAppointmentCubit>(),
            child: PaymobMobileGetway(
              webUri: mobileData['webUri'],
              walletType: mobileData['walletType'],
              appointmentDetails: mobileData['appointmentDetails'],
            ),
          ),
        );

      case Routes.bookingScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: getIt<BookingAppointmentCubit>(),
            child: const BookingScreen(),
          ),
        );

      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
