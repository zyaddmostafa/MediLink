import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../widgets/doctors/doctors_list_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: CustomAppBar(
                appBarwidget: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Text('My Favorites', style: AppTextStyles.font16Bold),
                ),
              ),
            ),
            verticalSpacing(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Favorite Doctors', style: AppTextStyles.font18Bold),
                  SvgPicture.asset(Assets.svgsNotselected),
                ],
              ),
            ),
            verticalSpacing(24),
            Expanded(
              child: DoctorListView(
                isFavorite: true,
                doctors: [],
                buttonProperties: ButtonPropertiesModel(
                  text: 'Book Appointment',
                  textColor: AppColor.primary,
                  backgroundColor: AppColor.doctorCardButton,
                  onPressed: () {
                    context.pushNamed(Routes.doctorInfo);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
