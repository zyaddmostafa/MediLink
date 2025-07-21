import 'package:flutter_svg/svg.dart';

import '../helpers/app_assets.dart';
import '../helpers/extentions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? appBarwidget;
  const CustomAppBar({super.key, this.appBarwidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: context.pop,
          child: SvgPicture.asset(Assets.assetsSvgsBack),
        ),

        appBarwidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
