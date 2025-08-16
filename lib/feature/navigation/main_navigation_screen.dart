import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/dependency_injection.dart';
import '../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../booking/presentation/screen/booking_screen.dart';
import '../home/presentation/cubit/home_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
import '../home/presentation/screens/search_screen.dart';
import '../profile/presentation/screens/profile_screen.dart';
import 'widgets/bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    BlocProvider.value(
      value: getIt<HomeCubit>()..getAllDoctors(),
      child: const HomeScreen(),
    ),

    BlocProvider(
      create: (context) => BookingAppointmentCubit(getIt(), getIt()),
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
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          // If not on home screen, go back to home
          if (_currentIndex != 0) {
            setState(() {
              _currentIndex = 0;
            });
          } else {
            // Exit the app when on home screen
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTabTapped: _onTabTapped,
        ),
      ),
    );
  }
}
