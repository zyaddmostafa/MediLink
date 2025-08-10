import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'upcoming_appointment_list_item.dart';

class UpcomingAppoinmentsListView extends StatelessWidget {
  const UpcomingAppoinmentsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 24, right: 24),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(right: index == 4 ? 0 : 16),
            child: const UpcomingAppoinmentListItem(),
          );
        },
      ),
    );
  }
}
