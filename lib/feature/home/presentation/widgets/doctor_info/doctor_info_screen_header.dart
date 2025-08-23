import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/favorites/favorite_doctor_service.dart';
import '../../../../../core/favorites/favorite_toogle_method.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../data/model/doctor_model.dart';
import '../../cubit/home_cubit.dart';

class DoctorInfoScreenHeader extends StatefulWidget {
  final DoctorModel? doctor;
  const DoctorInfoScreenHeader({super.key, this.doctor});

  @override
  State<DoctorInfoScreenHeader> createState() => _DoctorInfoScreenHeaderState();
}

class _DoctorInfoScreenHeaderState extends State<DoctorInfoScreenHeader> {
  late final FavoriteDoctorService _favoriteService;
  @override
  void initState() {
    super.initState();
    _favoriteService = getIt<FavoriteDoctorService>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomAppBar(
        iconColor: AppColor.white,
        appBarwidget: Expanded(
          child: Row(
            children: [
              horizontalSpacing(16),
              Text(
                'Doctor Info',
                style: AppTextStyles.font18Bold.copyWith(color: AppColor.white),
              ),
              const Spacer(),

              horizontalSpacing(24),
              _favoriteDoctorToggleBlocBuiler(),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder<HomeCubit, HomeState> _favoriteDoctorToggleBlocBuiler() {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is DoctorByIdSuccess,
      builder: (context, state) {
        if (state is DoctorByIdSuccess) {
          return buildFavoriteIcon(_favoriteService, state.doctor!);
        }
        return Container();
      },
    );
  }
}
