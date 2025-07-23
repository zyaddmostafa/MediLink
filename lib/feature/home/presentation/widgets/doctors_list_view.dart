import 'package:flutter/material.dart';
import 'doctors_card.dart';

class DoctorListView extends StatelessWidget {
  final bool isFavorite;
  const DoctorListView({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // Performance optimizations
      physics: const BouncingScrollPhysics(),
      addAutomaticKeepAlives: false,
      // Layout
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: 5,

      // Separator (more efficient than manual padding)
      separatorBuilder: (context, index) => const SizedBox(height: 16),

      // Items
      itemBuilder: (context, index) {
        return DoctorsCard(isFavorite: isFavorite);
      },
    );
  }
}
