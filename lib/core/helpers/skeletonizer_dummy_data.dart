import '../../feature/booking/data/model/appointment_data.dart';
import '../../feature/home/data/model/doctor_model.dart';

class SkeletonizerDummyData {
  // Dummy DoctorModel for skeleton loading
  static DoctorModel get dummyDoctor => DoctorModel(
    id: 0,
    name: 'Dr. Loading Name Here',
    email: 'loading@example.com',
    phone: '+1234567890',
    photo: '',
    gender: 'male',
    address: 'Loading Address Street Name, City',
    description:
        'Loading doctor description text that will be shown as skeleton...',
    degree: 'Consultant',
    specialization: dummySpecialization,
    city: dummyCity,
    appointPrice: 150,
    startTime: '09:00 AM',
    endTime: '05:00 PM',
  );

  // Dummy Specialization
  static Specialization get dummySpecialization =>
      Specialization(id: 0, name: ' Specialization ');

  // Dummy City
  static City get dummyCity =>
      City(id: 0, name: ' City ', governrate: dummyGovernrate);

  // Dummy Governrate
  static Governrate get dummyGovernrate =>
      Governrate(id: 0, name: 'Loading Governrate Name');

  // Dummy PatientResponse
  static PatientResponse get dummyPatient => PatientResponse(
    id: 0,
    name: 'Loading Patient Full Name',
    email: 'patient.loading@example.com',
    phone: '+1234567890',
    gender: 'male',
  );

  // Dummy AppointmentData
  static AppointmentData get dummyAppointment => AppointmentData(
    id: 0,
    doctor: dummyDoctor,
    patient: dummyPatient,
    appointmentTime: 'Today, 10:00 AM - 11:00 AM',
    appointmentEndTime: '11:00 AM',
    status: 'upcoming',
    notes: 'Loading appointment notes and details...',
    appointmentPrice: 150,
  );

  // List of dummy appointments for loading multiple items (Home Screen Skeleton)
  static List<AppointmentData> get dummyAppointmentsList => [
    dummyAppointment.copyWith(
      id: 1,
      appointmentTime: 'Monday, October 14, 2025 10:00 AM',
      doctor: dummyDoctor.copyWith(
        name: 'Doctor One',
        specialization: Specialization(id: 1, name: 'Cardiology'),
      ),
    ),
    dummyAppointment.copyWith(
      id: 2,
      appointmentTime: 'Tuesday, October 15, 2025 2:30 PM',
      doctor: dummyDoctor.copyWith(
        name: 'Doctor Two',
        specialization: Specialization(id: 2, name: 'Dermatology'),
      ),
    ),
    dummyAppointment.copyWith(
      id: 3,
      appointmentTime: 'Wednesday, October 16, 2025 9:15 AM',
      doctor: dummyDoctor.copyWith(
        name: 'Doctor Three',
        specialization: Specialization(id: 3, name: 'Neurology'),
      ),
    ),
    dummyAppointment.copyWith(
      id: 4,
      appointmentTime: 'Friday, October 18, 2025 4:00 PM',
      doctor: dummyDoctor.copyWith(
        name: 'Doctor Four',
        specialization: Specialization(id: 4, name: 'Orthopedic'),
      ),
    ),
  ];

  // Dummy appointments grouped by time (for your tab structure)
  static List<AppointmentData> get dummyUpcomingAppointments => [
    dummyAppointment.copyWith(
      id: 1,
      appointmentTime: 'Today, 10:00 AM - 11:00 AM',
    ),
    dummyAppointment.copyWith(
      id: 2,
      appointmentTime: 'Today, 2:00 PM - 3:00 PM',
    ),
    dummyAppointment.copyWith(
      id: 3,
      appointmentTime: 'Tomorrow, 11:00 AM - 12:00 PM',
    ),
  ];

  static List<AppointmentData> get dummyCompletedAppointments => [
    dummyAppointment.copyWith(
      id: 3,
      appointmentTime: 'Yesterday, 11:00 AM - 12:00 PM',
      status: 'completed',
    ),
    dummyAppointment.copyWith(
      id: 4,
      appointmentTime: 'Last Week, 3:00 PM - 4:00 PM',
      status: 'completed',
    ),
  ];

  static List<AppointmentData> get dummyCancelledAppointments => [
    dummyAppointment.copyWith(
      id: 5,
      appointmentTime: 'Last Week, 9:00 AM - 10:00 AM',
      status: 'cancelled',
    ),
  ];
}

// Extension to create copies with different values for variety
extension AppointmentDataCopyWith on AppointmentData {
  AppointmentData copyWith({
    int? id,
    DoctorModel? doctor,
    PatientResponse? patient,
    String? appointmentTime,
    String? appointmentEndTime,
    String? status,
    String? notes,
    int? appointmentPrice,
  }) {
    return AppointmentData(
      id: id ?? this.id,
      doctor: doctor ?? this.doctor,
      patient: patient ?? this.patient,
      appointmentTime: appointmentTime ?? this.appointmentTime,
      appointmentEndTime: appointmentEndTime ?? this.appointmentEndTime,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      appointmentPrice: appointmentPrice ?? this.appointmentPrice,
    );
  }
}
