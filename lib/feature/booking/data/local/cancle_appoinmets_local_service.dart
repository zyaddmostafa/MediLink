import 'dart:developer';

import '../../../../core/hive/hive_service.dart';
import '../../../home/data/model/doctor_model.dart';
import '../model/appointment_data.dart';

class CancelledAppointmentsLocalService extends HiveService<AppointmentData> {
  // Singleton pattern
  CancelledAppointmentsLocalService._();
  static CancelledAppointmentsLocalService instance =
      CancelledAppointmentsLocalService._();

  @override
  String get boxName => 'cancelled_appointment_data_box';

  /// Add a cancelled appointment
  Future<void> addCanceledAppointment(AppointmentData appointment) async {
    await add(appointment);
    log('Added cancelled appointment: ${appointment.id}');
  }

  /// Get all cancelled appointments
  List<AppointmentData> getCancelledAppointments() {
    return getAll();
  }

  /// Delete cancelled appointment at specific index
  Future<void> deleteCancelledAppointmentAt(int index) async {
    await deleteAt(index);
    log('Deleted cancelled appointment at index: $index');
  }

  /// Clear all cancelled appointments
  Future<void> clearCancelledAppointments() async {
    await clear();
  }

  /// Get doctors from cancelled appointments
  static List<DoctorModel> getCancelledDoctorsByAppointments(
    List<AppointmentData> appointments,
  ) {
    return appointments
        .map((appointment) => appointment.doctor)
        .toList(growable: false);
  }

  /// Delete cancelled appointment by ID
  Future<void> deleteCancelledAppointmentById(int id) async {
    log('Attempting to delete cancelled appointment with id: $id');

    // Find and delete the appointment with the matching ID
    final appointments = getAllValues().toList();
    for (int i = 0; i < appointments.length; i++) {
      if (appointments[i].id == id) {
        await deleteAt(i);
        log('Successfully deleted cancelled appointment with id: $id');
        return;
      }
    }

    log('No cancelled appointment found with id: $id');
  }

  /// Find cancelled appointment by ID
  AppointmentData? findCancelledAppointmentById(int id) {
    return findFirst((appointment) => appointment.id == id);
  }

  /// Get cancelled appointments by doctor ID
  List<AppointmentData> getCancelledAppointmentsByDoctorId(int doctorId) {
    return findWhere((appointment) => appointment.doctor.id == doctorId);
  }
}
