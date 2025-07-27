import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/app_color.dart';
import '../../../data/model/doctor_model.dart';
import '../../cubit/home_cubit.dart';
import 'book_appoinment_bottom_sheet.dart';

class DoctorBottomSheetBlocBuilder extends StatelessWidget {
  const DoctorBottomSheetBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is DoctorByIdSuccess ||
          current is DoctorByIdLoading ||
          current is DoctorByIdError,
      builder: (context, state) {
        if (state is DoctorByIdLoading) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.615,
            width: double.infinity,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is DoctorByIdError) {
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.615,
            width: double.infinity,
            decoration: const ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
            child: Center(
              child: Text('Error: ${state.error.message ?? 'Unknown error'}'),
            ),
          );
        } else if (state is DoctorByIdSuccess) {
          final DoctorModel doctor = state.doctor!;
          return BookAppointmentBottomSheet(doctor: doctor);
        }
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.615,
          width: double.infinity,
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: AppColor.primary),
          ),
        );
      },
    );
  }
}
