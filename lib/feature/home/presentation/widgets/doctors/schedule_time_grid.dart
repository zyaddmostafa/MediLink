import 'package:flutter/material.dart';
import '../../../../../core/helpers/doctors_helper.dart';
import '../doctor_info/schedule_time_item.dart';

class ScheduleTimeGrid extends StatefulWidget {
  final String startTime;
  final String endTime;
  final Function(String)? onTimeSelected;
  final String? selectedTime;

  const ScheduleTimeGrid({
    super.key,
    required this.startTime,
    required this.endTime,
    this.onTimeSelected,
    this.selectedTime,
  });

  @override
  State<ScheduleTimeGrid> createState() => _ScheduleTimeGridState();
}

class _ScheduleTimeGridState extends State<ScheduleTimeGrid> {
  String? selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    selectedTimeSlot = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    final timeSlots = DoctorsHelpers.generateTimeSlots(
      startTime: widget.startTime,
      endTime: widget.endTime,
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5, // Adjust this to control height
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final timeSlot = timeSlots[index];
        final isSelected = selectedTimeSlot == timeSlot;

        return ScheduleTimeItem(
          timeSlot: timeSlot,
          isSelected: isSelected,
          onTap: () {
            setState(() {
              selectedTimeSlot = timeSlot;
            });
            if (widget.onTimeSelected != null) {
              widget.onTimeSelected!(timeSlot);
            }
          },
        );
      },
    );
  }
}
