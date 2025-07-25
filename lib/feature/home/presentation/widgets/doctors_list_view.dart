import 'package:flutter/material.dart';
import '../../data/model/doctor_model.dart';
import 'doctors_card.dart';

class DoctorListView extends StatelessWidget {
  final bool isFavorite;
  final List<DoctorModel> doctors;
  // Simple: just pass the number you want
  final bool shrinkWrap; // Control shrinkWrap behavior

  const DoctorListView({
    super.key,
    required this.isFavorite,
    required this.doctors,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Performance optimizations
      physics: const BouncingScrollPhysics(),
      addAutomaticKeepAlives: false,
      shrinkWrap: shrinkWrap, // Use the parameter
      // Layout
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: doctors.length,

      separatorBuilder: (context, index) => const SizedBox(height: 16),

      // Items
      itemBuilder: (context, index) {
        return DoctorsCard(isFavorite: isFavorite, doctor: doctors[index]);
      },
    );
  }
}
