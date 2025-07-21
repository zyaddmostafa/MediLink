import 'app_regex.dart';

class FormValidators {
  static String? validateEmail(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.emailRequired;
    if (!AppRegex.isValidEmail(value!)) return AppStrings.invalidEmail;
    return null;
  }

  static String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.passwordRequired;
    if (value!.length < 8) return AppStrings.passwordTooShort;
    if (!AppRegex.isValidPassword(value)) {
      return AppStrings.invalidPasswordFormat;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value?.isEmpty ?? true) return AppStrings.confirmPasswordRequired;
    if (value != password) return AppStrings.passwordsDoNotMatch;
    return null;
  }

  static String? validateName(String? value) {
    if (value?.isEmpty ?? true) return 'Name is required';
    if (value!.length < 3) return 'Name must be at least 3 characters long';
    return null;
  }

  static String? validatePhone(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.phoneRequired;
    if (!AppRegex.isValidPhoneNumber(value!)) return AppStrings.invalidPhone;
    return null;
  }
}

class AppStrings {
  static const String emailRequired = 'Email is required';
  static const String invalidEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort =
      'Password must be at least 8 characters long';
  static const String invalidPasswordFormat =
      'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
  static const String confirmPasswordRequired = 'Please confirm your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';

  static const String phoneRequired = 'Phone number is required';
  static const String invalidPhone = 'Please enter a valid phone number';
}
