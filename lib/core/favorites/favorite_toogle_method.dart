import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../feature/home/data/model/doctor_model.dart';
import '../helpers/app_assets.dart';
import '../theme/app_color.dart';
import 'favorite_doctor_service.dart';

Widget buildFavoriteIcon(
  FavoriteDoctorService favoriteService,
  DoctorModel doctor,
) {
  return StreamBuilder<List<DoctorModel>>(
    stream: favoriteService.getFavoriteDoctorsStream(),
    builder: (context, snapshot) {
      final isFavorite = favoriteService.isFavorite(doctor.id!);

      return GestureDetector(
        onTap: () async {
          await favoriteService.toggleFavorite(doctor);
        },
        child: SvgPicture.asset(
          isFavorite ? Assets.svgsFavactive : Assets.svgsFavinactive,
          color: AppColor.red,
        ),
      );
    },
  );
}
