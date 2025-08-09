import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

import '../../../home/data/model/doctor_model.dart';
import '../model/appoitmnet_data.dart';
import '../model/store_appointment_response.dart';

class CancelledAppointmentsLocalService {
  // Your service methods for cancelled appointments
  // Box names
  static const String _cancelledAppointmentsBoxName =
      'cancelled_appointments_box';

  // Initialization
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdaptersIfNeeded();
    await _openCoreBoxes();
  }

  // Adapter registration
  static void _registerAdaptersIfNeeded() {
    // Register AppointmentData adapter (typeId: 0)
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DoctorModelAdapter());
    }
    // Register Specialization adapter (typeId: 1)
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(SpecializationAdapter());
    }
    // Register City adapter (typeId: 2)
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CityAdapter());
    }
    // Register Governrate adapter (typeId: 3)
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(GovernrateAdapter());
    }
    // Register AppointmentData adapter (typeId: 4)
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(AppointmentDataAdapter());
    }
    // Register PatientResponse adapter (typeId: 5)
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(PatientResponseAdapter());
    }
  }

  // Open core boxes used across the app
  static Future<void> _openCoreBoxes() async {
    await Hive.openBox<AppointmentData>(_cancelledAppointmentsBoxName);
  }

  // Generic helpers
  static Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return Hive.openBox<T>(boxName);
  }

  static Box<T> box<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  // Domain-specific helpers: Cancelled Appointments
  static Box<AppointmentData> get _cancelledAppointmentsBox =>
      Hive.box<AppointmentData>(_cancelledAppointmentsBoxName);

  Future<void> addCancelledAppointment(AppointmentData appointment) async {
    try {
      log(
        'LocalService: Adding cancelled appointment for doctor: ${appointment.doctor.name}',
      );
      await _cancelledAppointmentsBox.add(appointment);
      log('LocalService: Successfully added to Hive box');
    } catch (error) {
      log('LocalService: Error adding to Hive: $error');
      rethrow;
    }
  }

  static List<AppointmentData> getCancelledAppointments() {
    return _cancelledAppointmentsBox.values.toList(growable: false);
  }

  static Future<void> deleteCancelledAppointmentAt(int index) async {
    await _cancelledAppointmentsBox.deleteAt(index);
  }

  static Future<void> clearCancelledAppointments() async {
    log('Clearing all cancelled appointments from Hive box');
    await _cancelledAppointmentsBox.clear();
  }

  static List<DoctorModel> getCancelledDoctors() {
    return _cancelledAppointmentsBox.values
        .map((appointment) => appointment.doctor)
        .toList(growable: false);
  }
}
