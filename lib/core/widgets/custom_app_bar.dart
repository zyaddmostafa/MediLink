import '../helpers/extentions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? appBarwidget;
  const CustomAppBar({super.key, this.appBarwidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(onTap: context.pop, child: const Icon(Icons.arrow_back)),
        appBarwidget ?? const SizedBox.shrink(),
      ],
    );
  }
}
