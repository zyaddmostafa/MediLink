import 'dart:math';
import 'app_assets.dart';

class DoctorsImages {
  DoctorsImages._();

  // List of male doctor images
  static const List<String> maleDoctorImages = [
    Assets.imagesDoctorMale1,
    Assets.imagesDoctorMale2,
    Assets.imagesDoctorMale3,
    Assets.imagesDoctorMale4,
  ];

  // List of female doctor images
  static const List<String> femaleDoctorImages = [
    Assets.imagesDoctorFemale1,
    Assets.imagesDoctorFemale2,
    Assets.imagesDoctorFemale3,
  ];

  // Random number generator
  static final Random _random = Random();

  /// Get a random doctor image based on gender
  ///
  /// [gender] should be 'male' or 'female' (case insensitive)
  /// Returns a random image path from the corresponding gender list
  /// If gender is not recognized, returns a random image from all available images
  static String getRandomDoctorImage(String gender) {
    final String normalizedGender = gender.toLowerCase().trim();

    switch (normalizedGender) {
      case 'male':
        return getRandomMaleDoctorImage();
      case 'female':
        return getRandomFemaleDoctorImage();
      default:
        // If gender is not recognized, return random from all images
        final List<String> allImages = [
          ...maleDoctorImages,
          ...femaleDoctorImages,
        ];
        return allImages[_random.nextInt(allImages.length)];
    }
  }

  /// Get a random male doctor image
  static String getRandomMaleDoctorImage() {
    return maleDoctorImages[_random.nextInt(maleDoctorImages.length)];
  }

  /// Get a random female doctor image
  static String getRandomFemaleDoctorImage() {
    return femaleDoctorImages[_random.nextInt(femaleDoctorImages.length)];
  }
}
