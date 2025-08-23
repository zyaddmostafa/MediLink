import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/favorites/favorite_doctor_service.dart';
import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/extentions.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/model/button_properties_model.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dioalog.dart';
import '../../../../core/widgets/no_result_widget.dart';
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
            getIt<FavoriteDoctorService>().getAllFavoriteDoctors().isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Favorite Doctors',
                          style: AppTextStyles.font18Bold,
                        ),
                        const ToggletoSelectAllDoctors(),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            verticalSpacing(24),
            Expanded(
              child: StreamBuilder(
                stream: getIt<FavoriteDoctorService>()
                    .getFavoriteDoctorsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('Error fetching favorites'),
                    );
                  }
                  final doctors = snapshot.data ?? [];
                  if (doctors.isEmpty) {
                    return const NoResultWidget(
                      message: 'No favorite doctors found',
                    );
                  }
                  return DoctorListView(
                    doctors: doctors,
                    buttonProperties: ButtonPropertiesModel(
                      text: 'Book Appointment',
                      textColor: AppColor.primary,
                      backgroundColor: AppColor.doctorCardButton,
                      onPressed: () {
                        context.pushNamed(
                          Routes.doctorInfo,
                          arguments: doctors.first.id,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToggletoSelectAllDoctors extends StatefulWidget {
  const ToggletoSelectAllDoctors({super.key});

  @override
  State<ToggletoSelectAllDoctors> createState() =>
      _ToggletoSelectAllDoctorsState();
}

class _ToggletoSelectAllDoctorsState extends State<ToggletoSelectAllDoctors> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        if (_isSelected) {
          CustomDialog.showConfirmationDialog(
            title: 'Delete All Doctors',
            message: 'Are you sure you want to Delete all Favorites Doctors?',
            onConfirm: () async {
              await getIt<FavoriteDoctorService>().clear();
              setState(() {
                _isSelected = false;
              });
              if (context.mounted) {
                context.pop();
              }
            },
            onCancel: () {
              setState(() {
                _isSelected = false;
              });
              if (context.mounted) {
                context.pop();
              }
            },
            context: context,
          );
        }
      },
      child: SvgPicture.asset(
        _isSelected ? Assets.svgsSelected : Assets.svgsNotselected,
      ),
    );
  }
}
