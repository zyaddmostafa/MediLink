import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../cubit/booking_appointment_cubit.dart';
import 'appointment_tab_bar_body.dart';

class AppointmentTabBarView extends StatefulWidget {
  const AppointmentTabBarView({super.key});

  @override
  State<AppointmentTabBarView> createState() => _AppointmentTabBarViewState();
}

class _AppointmentTabBarViewState extends State<AppointmentTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;

    final cubit = context.read<BookingAppointmentCubit>();

    if (_tabController.index == 1) {
      cubit.getCancelledAppointments();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: AppColor.primary,
          unselectedLabelColor: Colors.grey,
          labelStyle: AppTextStyles.font16Regular,
          unselectedLabelStyle: AppTextStyles.font16Regular,
          indicatorColor: AppColor.primary,
          indicatorWeight: 3,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: Colors.grey.shade300,
          tabs: const [
            Tab(text: 'Upcoming'),
            Tab(text: 'Cancelled'),
          ],
        ),
        verticalSpacing(24),
        Expanded(child: AppointmentTabBarBody(tabController: _tabController)),
      ],
    );
  }
}
