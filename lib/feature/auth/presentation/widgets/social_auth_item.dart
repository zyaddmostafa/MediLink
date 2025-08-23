import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_color.dart';

class SocialAuthItem extends StatelessWidget {
  final String svgImage;
  final VoidCallback onTap;
  const SocialAuthItem({
    super.key,
    required this.svgImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: const ShapeDecoration(
          color: AppColor.blueGrey,
          shape: OvalBorder(),
        ),
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(svgImage),
      ),
    );
  }
}
