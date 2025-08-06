class ApiConstants {
  static const String apiBaseUrl = "https://vcare.integration25.com/api/";

  // Authentication endpoints
  static const String login = 'auth/login';
  static const String signup = "auth/register";
  static const String logout = "auth/logout";

  // Doctor endpoints

  static const String getAllDoctors = "doctor/index";
  static const String getDoctorById = "doctor/show";
  static const String getDoctorsByCategory = "specialization/show";
  static const String searchDoctors = "doctor/doctor-search";
  // Appointment endpoints
  static const String bookAppointment = "appointment/store";
}
