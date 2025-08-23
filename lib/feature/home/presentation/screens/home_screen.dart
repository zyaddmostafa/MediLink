import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../booking/presentation/cubit/booking_appointment_cubit.dart';
import '../cubit/home_cubit.dart';
import '../widgets/categories/categories_section.dart';
import '../widgets/doctors/doctors_section.dart';
import '../widgets/home_header.dart';
import '../widgets/upcomping/upcoming_appoitment_bloc_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data after the widget is built

    _loadInitialData();
  }

  void _loadInitialData() {
    final homeCubit = context.read<HomeCubit>();
    // Only load if no data has been loaded yet

    homeCubit.getAllDoctors();

    // Also load appointments for the upcoming appointments section
    final bookingCubit = context.read<BookingAppointmentCubit>();

    bookingCubit.getFilteredAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: HomeHeader(
                onNotificationTap: () =>
                    context.pushNamed(Routes.notificationScreen),
                onFavoriteTap: () => context.pushNamed(Routes.favoriteScreen),
              ),
            ),

            verticalSpacing(24),

            const UpComingAppoitmentBlocBuilder(),

            const CategoriesSection(),

            verticalSpacing(24),

            const Expanded(child: DoctorsSection()),
          ],
        ),
      ),
    );
  }
}
