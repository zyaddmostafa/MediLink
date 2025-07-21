class AppRegex {
  // email regex
  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
  );

  // phone number regex
  static final RegExp phoneNumberRegex = RegExp(r"^\+?[1-9]\d{1,14}$");

  // password regex (at least 8 characters, one uppercase, one lowercase, one digit, one special character)
  static final RegExp passwordRegex = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$",
  );

  // get regex bool is valied or not
  static bool isValidEmail(String email) {
    return emailRegex.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumberRegex.hasMatch(phoneNumber);
  }

  static bool isValidPassword(String password) {
    return passwordRegex.hasMatch(password);
  }
}
