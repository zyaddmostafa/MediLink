import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/di/dependency_injection.dart';
import '../../core/widgets/keep_alive_wrapper.dart';
import '../auth/presentation/cubit/auth_cubit.dart';
import '../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../booking/presentation/screen/booking_screen.dart';
import '../home/presentation/cubit/home_cubit.dart';
import '../home/presentation/screens/home_screen.dart';
import '../home/presentation/screens/search_screen.dart';
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
  late final PageController _pageController = PageController();

  // Cache for BLoC providers to avoid recreating them
  late final HomeCubit _homeCubit = getIt<HomeCubit>();
  late final BookingAppointmentCubit _bookingCubit =
      getIt<BookingAppointmentCubit>();
  late final AuthCubit _authCubit = getIt<AuthCubit>();

  // Pre-built screens with KeepAlive for state preservation
  late final List<Widget> _screens = [
    KeepAliveWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _homeCubit),
          BlocProvider.value(value: _bookingCubit),
        ],
        child: const HomeScreen(),
      ),
    ),
    KeepAliveWrapper(
      child: BlocProvider.value(
        value: _bookingCubit,
        child: const BookingScreen(),
      ),
    ),
    KeepAliveWrapper(
      child: BlocProvider.value(value: _homeCubit, child: const SearchScreen()),
    ),
    KeepAliveWrapper(
      child: BlocProvider.value(
        value: _authCubit,
        child: const ProfileScreen(),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Delay user profile loading to avoid blocking UI
    _loadUserProfileIfNeeded();
  }

  void _loadUserProfileIfNeeded() async {
    context.read<UserCubit>().getUserProfile();
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _homeCubit.close();
    _bookingCubit.close();
    _authCubit.close();
    super.dispose();
  }
}
