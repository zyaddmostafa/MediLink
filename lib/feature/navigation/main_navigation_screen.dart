import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/dependency_injection.dart';
import '../../core/theme/app_text_styles.dart';
import '../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../booking/presentation/screen/booking_screen.dart';
import '../home/presentation/cubit/home_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
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
    BlocProvider.value(
      value: getIt<BookingAppointmentCubit>()..getStoredAppointments(),
      child: const BookingScreen(),
    ),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles.font18Bold),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text('Profile Screen', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
