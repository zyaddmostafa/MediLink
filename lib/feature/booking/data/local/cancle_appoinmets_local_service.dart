import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

import '../../../home/data/model/doctor_model.dart';

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
    // Register DoctorModel adapter (typeId: 0)
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
  }

  // Open core boxes used across the app
  static Future<void> _openCoreBoxes() async {
    await Hive.openBox<DoctorModel>(_cancelledAppointmentsBoxName);
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
  static Box<DoctorModel> get _cancelledAppointmentsBox =>
      Hive.box<DoctorModel>(_cancelledAppointmentsBoxName);

  Future<void> addCancelledAppointment(DoctorModel appointment) async {
    try {
      log(
        'LocalService: Adding cancelled appointment for doctor: ${appointment.name}',
      );
      await _cancelledAppointmentsBox.add(appointment);
      log('LocalService: Successfully added to Hive box');
    } catch (error) {
      log('LocalService: Error adding to Hive: $error');
      rethrow;
    }
  }

  static List<DoctorModel> getCancelledAppointments() {
    return _cancelledAppointmentsBox.values.toList(growable: false);
  }

  static Future<void> deleteCancelledAppointmentAt(int index) async {
    await _cancelledAppointmentsBox.deleteAt(index);
  }

  static Future<void> clearCancelledAppointments() async {
    await _cancelledAppointmentsBox.clear();
  }
}
