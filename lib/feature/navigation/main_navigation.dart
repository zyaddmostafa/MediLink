import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/dependency_injection.dart';
import '../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../booking/presentation/screen/booking_screen.dart';
import '../home/presentation/cubit/home_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
import '../home/presentation/screens/search_screen.dart';
import '../profile/data/local/user_local_service.dart';
import '../profile/presentation/cubit/user_cubit.dart';
import '../profile/presentation/screens/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    final savedUser = getIt<UserLocalService>().getUser();
    if (savedUser == null) {
      context.read<UserCubit>().getUserProfile();
      getIt<UserLocalService>().getUser();
    }
  }

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..getAllDoctors()),
        BlocProvider(
          create: (context) =>
              getIt<BookingAppointmentCubit>()..getFilteredAppointments(),
        ),
      ],
      child: const HomeScreen(),
    ),

    BlocProvider.value(
      value: getIt<BookingAppointmentCubit>(),
      child: const BookingScreen(),
    ),
    BlocProvider.value(value: getIt<HomeCubit>(), child: const SearchScreen()),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}
