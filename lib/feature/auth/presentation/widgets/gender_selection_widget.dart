import '../../../../core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

enum Gender { male, female }

class GenderSelectionWidget extends StatefulWidget {
  final Gender? selectedGender;
  final ValueChanged<Gender> onGenderChanged;
  final String? label;

  const GenderSelectionWidget({
    super.key,
    this.selectedGender,
    required this.onGenderChanged,
    this.label,
  });

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  Gender _selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTextStyles.font16Medium),
          verticalSpacing(8),
        ],
        Row(
          children: [
            Expanded(
              child: _GenderOption(
                gender: Gender.male,
                label: 'Male',
                icon: Icons.male,
                isSelected: _selectedGender == Gender.male,
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.male;
                  });
                  widget.onGenderChanged(Gender.male);
                },
              ),
            ),
            horizontalSpacing(16),
            Expanded(
              child: _GenderOption(
                gender: Gender.female,
                label: 'Female',
                icon: Icons.female,
                isSelected: _selectedGender == Gender.female,
                onTap: () {
                  setState(() {
                    _selectedGender = Gender.female;
                  });
                  widget.onGenderChanged(Gender.female);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  final Gender gender;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _GenderOption({
    required this.gender,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // This is the main container that holds the gender option
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor.withOpacity(0.1)
              : AppColor.white,
          border: Border.all(
            color: isSelected
                ? AppColor.primaryColor
                : AppColor.grey.withValues(alpha: 0.5),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // This is the main content inside the container the text and icon
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColor.primaryColor : AppColor.black,
              size: 24,
            ),
            horizontalSpacing(8),
            Text(
              label,
              style: AppTextStyles.font14Medium.copyWith(
                color: isSelected ? AppColor.primaryColor : AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
