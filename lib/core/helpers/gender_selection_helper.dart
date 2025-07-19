import '../../feature/auth/presentation/widgets/gender_selection_widget.dart';

class GenderSelectionHelper {
  static int selectedGender(Gender? selectedGender) {
    // Handle the gender selection
    switch (selectedGender) {
      case Gender.male:
        return 0; // Assuming

      case Gender.female:
        return 1;

      default:
        return 0;
      // Invalid selection
    }
  }
}
