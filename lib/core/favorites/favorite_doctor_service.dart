import 'dart:developer';

import '../../feature/home/data/model/doctor_model.dart';
import '../hive/hive_service.dart';

class FavoriteDoctorService extends HiveService<DoctorModel> {
  static const String _boxName = 'favorite_doctors';

  @override
  String get boxName => _boxName;

  // Add doctor to favorites
  Future<void> addToFavorites(DoctorModel doctor) async {
    log('Adding doctor to favorites: ${doctor.id}');
    final existingDoctor = getFavoriteDoctor(doctor.id!);
    if (doctor.id != null && existingDoctor == null) {
      await put(doctor.id.toString(), doctor);
    }
  }

  // Remove doctor from favorites
  Future<void> removeFromFavorites(int doctorId) async {
    log('Removing doctor from favorites: $doctorId');
    await delete(doctorId.toString());
  }

  // Check if doctor is favorite
  bool isFavorite(int doctorId) {
    try {
      if (doctorId <= 0) return false;
      return containsKey(doctorId.toString());
    } catch (e) {
      // If there's an error reading from Hive, assume not favorite
      return false;
    }
  }

  // Toggle favorite status
  Future<void> toggleFavorite(DoctorModel doctor) async {
    log('Toggling favorite status for doctor: ${doctor.id}');
    if (doctor.id != null) {
      // Check if doctor is already in favorites
      final existingDoctor = getFavoriteDoctor(doctor.id!);

      if (existingDoctor != null) {
        // Doctor exists in favorites, remove it
        await removeFromFavorites(doctor.id!);
      } else {
        // Doctor not in favorites, add the complete doctor model
        await addToFavorites(doctor);
      }
    }
  }

  // Get favorite doctor by ID
  DoctorModel? getFavoriteDoctor(int doctorId) {
    return get(doctorId.toString());
  }

  // Get stream of favorite doctors for reactive UI
  Stream<List<DoctorModel>> getFavoriteDoctorsStream() {
    return getAllStream();
  }

  List<DoctorModel> getAllFavoriteDoctors() {
    return getAll();
  }

  // Get stream of favorite doctor IDs (for backward compatibility)
  Stream<List<int>> getFavoritesStream() {
    return getFavoriteDoctorsStream().map(
      (doctors) => doctors
          .where((doctor) => doctor.id != null)
          .map((doctor) => doctor.id!)
          .toList(),
    );
  }

  Future<void> clearAllFavorites() async {
    await clear();
  }
}
