import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/booking_appointment_cubit.dart';
import '../widget/appointment_tab_bar_view.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger data loading when the booking screen is first initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<BookingAppointmentCubit>().getStoredAppointments();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text('Appointments', style: AppTextStyles.font16Bold),

              verticalSpacing(24),

              const Expanded(child: AppointmentTabBarView()),
            ],
          ),
        ),
      ),
    );
  }
}
