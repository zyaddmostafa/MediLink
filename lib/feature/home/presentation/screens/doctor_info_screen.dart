import 'package:flutter/material.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/theme/app_color.dart';
import '../widgets/doctor_info/doctor_bottom_sheet_bloc_builder.dart';
import '../widgets/doctor_info/doctor_info_screen_header.dart';

class DoctorInfoScreen extends StatelessWidget {
  const DoctorInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: DoctorInfoScreenHeader(),
            ),
            Positioned(
              top: 114,
              left: 0,
              right: 0,
              child: Image.asset(Assets.assetsImagesHeartBackgroundShadow),
            ),
            Positioned(
              top: 58,
              left: 60,
              right: 60,
              child: Image.asset(Assets.assetsImagesDoctorImage, height: 280),
            ),
          ],
        ),
      ),
      bottomSheet: const DoctorBottomSheetBlocBuilder(),
    );
  }
}
