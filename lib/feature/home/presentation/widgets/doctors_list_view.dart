import 'package:flutter/material.dart';

import 'doctors_card.dart';

class DoctorListView extends StatelessWidget {
  final bool isFavorite;
  const DoctorListView({super.key, required this.isFavorite});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: 5, // Number of doctors
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: index == 4 ? 0 : 16),
            child: DoctorsCard(
              isFavorite: isFavorite, // Pass the isFavorite flag
            ),
          );
        },
      ),
    );
  }
}
