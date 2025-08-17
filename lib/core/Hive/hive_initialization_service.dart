import 'package:hive_flutter/hive_flutter.dart';
import 'dart:developer';

import '../../feature/booking/data/local/cancle_appoinmets_local_service.dart';
import '../../feature/booking/data/model/appointment_data.dart';
import '../../feature/home/data/local/notification_local_service.dart';
import '../../feature/home/data/model/doctor_model.dart';
import '../../feature/home/data/model/notification_model.dart';
import '../../feature/profile/data/local/user_local_service.dart';
import '../../feature/profile/data/model/user_response.dart';
import '../di/dependency_injection.dart';
import '../favorites/favorite_doctor_service.dart';

class HiveInitializationService {
  HiveInitializationService();

  /// Initialize Hive with all adapters and boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openCoreBoxes();
    log('Hive initialization completed');
  }

  /// Register all Hive adapters
  static void _registerAdapters() {
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

    // Register AppointmentData adapter (typeId: 4)
    if (!Hive.isAdapterRegistered(4)) {
      Hive.registerAdapter(AppointmentDataAdapter());
    }

    // Register PatientResponse adapter (typeId: 5)
    if (!Hive.isAdapterRegistered(5)) {
      Hive.registerAdapter(PatientResponseAdapter());
    }
    // Register NotificationModel adapter (typeId: 6)
    if (!Hive.isAdapterRegistered(6)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    // Register UserModel adapter (typeId: 7)
    if (!Hive.isAdapterRegistered(7)) {
      Hive.registerAdapter(UserModelAdapter());
    }

    log('All Hive adapters registered successfully');
  }

  /// Open core boxes used across the app
  static Future<void> _openCoreBoxes() async {
    // Open cancelled appointments box
    await Hive.openBox<AppointmentData>(
      CancelledAppointmentsLocalService.instance.boxName,
    );
    await Hive.openBox<NotificationModel>(
      getIt<NotificationLocalService>().boxName,
    );

    // Open favorite doctors box
    await Hive.openBox<DoctorModel>(getIt<FavoriteDoctorService>().boxName);

    // Open user box
    await Hive.openBox<UserModel>(getIt<UserLocalService>().boxName);
    log('Core Hive boxes opened successfully');
  }

  /// Close all boxes
  static Future<void> closeAllBoxes() async {
    await Hive.close();
    log('All Hive boxes closed');
  }

  /// Get information about all open boxes
  static Map<String, dynamic> getHiveInfo() {
    final info = <String, dynamic>{};

    // Add information for known boxes
    if (Hive.isBoxOpen('cancelled_appointment_data_box')) {
      final box = Hive.box('cancelled_appointment_data_box');
      info['cancelled_appointment_data_box'] = {
        'length': box.length,
        'isEmpty': box.isEmpty,
        'type': 'AppointmentData',
      };
    }

    return info;
  }
}
