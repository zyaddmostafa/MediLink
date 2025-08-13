import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/helpers/dummy_doctor_list_data.dart';
import '../../../../core/helpers/skeletonizer_dummy_data.dart';
import '../../../../core/widgets/keep_alive_wrapper.dart';
import '../../../../core/widgets/no_result_widget.dart';
import '../../data/local/cancle_appoinmets_local_service.dart';
import '../cubit/booking_appointment_cubit.dart';
import 'canceled_Appoitmnet_list_view.dart';
import 'upcoming_appointment_list_view.dart';

class AppointmentTabBarBody extends StatelessWidget {
  final TabController tabController;

  const AppointmentTabBarBody({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        KeepAliveWrapper(child: _upcomingAppointmentBlocBuilder()),
        KeepAliveWrapper(child: _cancelledAppointmentBlocBuilder()),
      ],
    );
  }

  BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>
  _cancelledAppointmentBlocBuilder() {
    return BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>(
      buildWhen: (previous, current) =>
          current is GetCancelledAppointmentsSuccess ||
          current is GetCancelledAppointmentsFailure ||
          current is GetCancelledAppointmentsLoading,
      builder: (context, state) {
        if (state is GetCancelledAppointmentsLoading) {
          return Skeletonizer(
            enabled: true,
            child: CanceledAppoitmenttListView(
              cancelledDoctors: generateSkeletonDoctors(),
              cancelledAppointments:
                  SkeletonizerDummyData.dummyCancelledAppointments,
            ),
          );
        }

        if (state is GetCancelledAppointmentsFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }

        if (state is GetCancelledAppointmentsSuccess) {
          final cancelledAppointments = state.response;
          final cancelledDoctors =
              CancelledAppointmentsLocalService.getCancelledDoctorsByAppointments(
                cancelledAppointments,
              );
          if (cancelledAppointments.isNotEmpty) {
            return CanceledAppoitmenttListView(
              cancelledDoctors: cancelledDoctors,
              cancelledAppointments: cancelledAppointments,
            );
          } else {
            return const NoResultWidget(
              message: 'No cancelled appointments found.',
            );
          }
        }

        return const SizedBox.shrink();
      },
    );
  }

  BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>
  _upcomingAppointmentBlocBuilder() {
    return BlocBuilder<BookingAppointmentCubit, BookingAppointmentState>(
      buildWhen: (previous, current) =>
          current is GetStoredAppointmentsSuccess ||
          current is GetStoredAppointmentsFailure ||
          current is GetStoredAppointmentsLoading,
      builder: (context, state) {
        if (state is GetStoredAppointmentsLoading) {
          return Skeletonizer(
            enabled: true,
            child: UpcomingAppointmentListView(
              appointments: SkeletonizerDummyData.dummyUpcomingAppointments,
            ),
          );
        } else if (state is GetStoredAppointmentsFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is GetStoredAppointmentsSuccess) {
          final upcomingAppointments = state.response;
          if (upcomingAppointments.isNotEmpty) {
            return UpcomingAppointmentListView(
              appointments: upcomingAppointments,
            );
          } else {
            return const NoResultWidget(
              message: 'No upcoming appointments found.',
            );
          }
        }

        // Show skeleton loading initially while waiting for data
        return const SizedBox.shrink();
      },
    );
  }
}
