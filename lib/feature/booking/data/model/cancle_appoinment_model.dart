import '../../../home/data/model/doctor_model.dart';
import 'store_appointment_response.dart';

class CancelAppoinmentModel {
  final String doctorId;
  final String doctorName;
  final String doctorSpecialization;
  final String appointmentTime;

  CancelAppoinmentModel({
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialization,
    required this.appointmentTime,
  });

  cancelAppoinmentModelfromUpcomingAppointment(
    AppointmentData appointmentData,
    DoctorModel doctorModel,
  ) {
    return CancelAppoinmentModel(
      doctorId: doctorModel.id!.toString(),
      doctorName: doctorModel.name!,
      doctorSpecialization: doctorModel.specialization!.name!,
      appointmentTime: appointmentData.appointmentTime,
    );
  }
}
