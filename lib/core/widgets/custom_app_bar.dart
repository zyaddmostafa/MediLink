import 'package:flutter_svg/svg.dart';

import '../helpers/app_assets.dart';
import '../helpers/extentions.dart';
import 'package:flutter/material.dart';

import '../helpers/spacing.dart';
import '../theme/app_color.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? appBarwidget;
  final Color iconColor;
  const CustomAppBar({
    super.key,
    this.appBarwidget,
    this.iconColor = AppColor.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: context.pop,
          child: SvgPicture.asset(
            Assets.svgsBack,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        horizontalSpacing(16),
        appBarwidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
