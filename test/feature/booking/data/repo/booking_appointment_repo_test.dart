import 'package:doctor_appoinment/core/api_helpers/api_result.dart';
import 'package:doctor_appoinment/core/model/api_response_model.dart';
import 'package:doctor_appoinment/feature/booking/data/apis/booking_appointment_api_service.dart';
import 'package:doctor_appoinment/feature/booking/data/local/cancle_appoinmets_local_service.dart';
import 'package:doctor_appoinment/feature/booking/data/model/appointment_data.dart';
import 'package:doctor_appoinment/feature/booking/data/model/store_appointment_request.dart';
import 'package:doctor_appoinment/feature/booking/data/repo/booking_appointment_repo.dart';
import 'package:doctor_appoinment/feature/home/data/model/doctor_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBookingAppointmentApiService extends Mock
    implements BookingAppointmentApiService {}

class MockCancelledAppointmentsLocalService extends Mock
    implements CancelledAppointmentsLocalService {}

void main() {
  late BookingAppointmentRepo bookingAppointmentRepo;
  late MockBookingAppointmentApiService mockBookingAppointmentApiService;
  late MockCancelledAppointmentsLocalService
  mockCancelledAppointmentsLocalService;

  setUp(() {
    mockBookingAppointmentApiService = MockBookingAppointmentApiService();
    mockCancelledAppointmentsLocalService =
        MockCancelledAppointmentsLocalService();
    bookingAppointmentRepo = BookingAppointmentRepo(
      mockBookingAppointmentApiService,
      mockCancelledAppointmentsLocalService,
    );
  });

  test('should create BookingAppointmentRepo instance', () {
    expect(bookingAppointmentRepo, isA<BookingAppointmentRepo>());
  });

  test(
    'test getStoredAppointments success it should return a list of appointments',
    () async {
      // Arrange
      final appointments = List.generate(
        5,
        (index) => AppointmentData(
          id: index + 1,
          doctor: DoctorModel(id: 1, name: 'Doctor $index'),
          patient: PatientResponse(
            id: 1,
            name: 'Patient $index',
            email: 'patient$index@example.com',
            phone: '1234567890',
            gender: 'Male',
          ),
          appointmentTime: '',
          appointmentEndTime: '',
          status: '',
          notes: '',
          appointmentPrice: 200,
        ),
      );
      final apiResponse = ApiResponseModel<List<AppointmentData>>(
        message: 'Appointments fetched successfully',
        responseData: appointments,
        status: true,
        code: 200,
      );

      when(
        () => mockBookingAppointmentApiService.getStoredAppointments(),
      ).thenAnswer((_) async => apiResponse);

      // Act
      final result = await bookingAppointmentRepo.getStoredAppointments();

      // Assert
      expect(result, isA<Success<ApiResponseModel<List<AppointmentData>>>>());
    },
  );

  test('test storeAppointments failure', () async {
    // Arrange
    final storeappointment = StoreAppointmentRequest(
      doctorId: '1',
      appointmentDateAndTime: DateTime.now().toString(),
      message: 'Need consultation',
    );

    when(
      () => mockBookingAppointmentApiService.storeAppointment(storeappointment),
    ).thenThrow((_) async => isA<Exception>());

    // Act
    final result = await bookingAppointmentRepo.storeAppointment(
      storeappointment,
    );

    // Assert
    expect(result, isA<Failure<ApiResponseModel<AppointmentData>>>());
  });
}
