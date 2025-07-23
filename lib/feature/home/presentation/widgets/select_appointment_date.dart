import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/helpers/app_assets.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A widget for selecting appointment dates with expandable day and month pickers
class SelectAppointmentDate extends StatefulWidget {
  /// Callback function called when a date is selected
  final ValueChanged<DateTime>? onDateSelected;

  const SelectAppointmentDate({super.key, this.onDateSelected});

  @override
  State<SelectAppointmentDate> createState() => _SelectAppointmentDateState();
}

class _SelectAppointmentDateState extends State<SelectAppointmentDate> {
  static const String _defaultDayTitle = 'Days';
  static const String _defaultMonthTitle = 'Months';
  static const int _daysPerWeek = 7;
  static const int _monthsPerRow = 3;
  static const double _gridChildAspectRatio = 1.0;
  static const double _monthGridChildAspectRatio = 2.0;

  DateTime _selectedDate = DateTime.now();
  bool _isDaysExpanded = false;
  bool _isMonthsExpanded = false;
  String _selectedDayTitle = _defaultDayTitle;
  String _selectedMonthTitle = _defaultMonthTitle;

  @override
  void initState() {
    super.initState();
    // _selectedDate is already initialized above
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSelectionRow(),
        if (_isDaysExpanded) _buildDaysGrid(),
        if (_isMonthsExpanded) _buildMonthsGrid(),
      ],
    );
  }

  /// Builds the horizontal row containing day and month selection containers
  Widget _buildSelectionRow() {
    return Row(
      children: [
        Expanded(
          child: _SelectionContainer(
            title: _selectedDayTitle,
            isExpanded: _isDaysExpanded,
            onTap: _toggleDaysExpansion,
          ),
        ),
        horizontalSpacing(12),
        Expanded(
          child: _SelectionContainer(
            title: _selectedMonthTitle,
            isExpanded: _isMonthsExpanded,
            onTap: _toggleMonthsExpansion,
          ),
        ),
      ],
    );
  }

  /// Builds the days grid when expanded
  Widget _buildDaysGrid() {
    return _GridContainer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _daysPerWeek,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: _gridChildAspectRatio,
        ),
        itemCount: _getDaysInCurrentMonth().length,
        itemBuilder: _buildDayItem,
      ),
    );
  }

  /// Builds the months grid when expanded
  Widget _buildMonthsGrid() {
    return _GridContainer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _monthsPerRow,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: _monthGridChildAspectRatio,
        ),
        itemCount: _monthNames.length,
        itemBuilder: _buildMonthItem,
      ),
    );
  }

  /// Builds individual day items in the grid
  Widget _buildDayItem(BuildContext context, int index) {
    final day = _getDaysInCurrentMonth()[index];
    final isSelected = _isDateSelected(day);
    final isEnabled = _isDayEnabled(day);

    return _SelectableItem(
      text: '${day.day}',
      isSelected: isSelected,
      isEnabled: isEnabled,
      onTap: isEnabled ? () => _selectDay(day) : null,
    );
  }

  /// Builds individual month items in the grid
  Widget _buildMonthItem(BuildContext context, int index) {
    final isSelected = _isMonthSelected(index + 1);
    final isEnabled = _isMonthEnabled(index + 1);

    return _SelectableItem(
      text: _monthNames[index],
      isSelected: isSelected,
      isEnabled: isEnabled,
      onTap: isEnabled
          ? () => _selectMonth(index + 1, _monthNames[index])
          : null,
    );
  }

  /// Toggles the expansion state of the days section
  void _toggleDaysExpansion() {
    setState(() {
      _isDaysExpanded = !_isDaysExpanded;
      if (_isDaysExpanded) {
        _isMonthsExpanded = false;
      }
    });
  }

  /// Toggles the expansion state of the months section
  void _toggleMonthsExpansion() {
    setState(() {
      _isMonthsExpanded = !_isMonthsExpanded;
      if (_isMonthsExpanded) {
        _isDaysExpanded = false;
      }
    });
  }

  /// Handles day selection
  void _selectDay(DateTime day) {
    setState(() {
      _selectedDate = day;
      _selectedDayTitle = '${day.day}';
      _isDaysExpanded = false;
    });
    widget.onDateSelected?.call(day);
  }

  /// Handles month selection
  void _selectMonth(int month, String monthName) {
    setState(() {
      _selectedDate = DateTime(_selectedDate.year, month, _selectedDate.day);
      _selectedMonthTitle = monthName;
      _isMonthsExpanded = false;

      // Reset day selection when month changes
      _selectedDayTitle = _defaultDayTitle;

      // If current month is selected and current day is not valid, select today
      if (month == DateTime.now().month) {
        final today = DateTime.now();
        if (_selectedDate.day < today.day) {
          _selectedDate = DateTime(_selectedDate.year, month, today.day);
        }
      }
    });
    widget.onDateSelected?.call(_selectedDate);
  }

  /// Returns list of days in the selected month with appropriate filtering
  List<DateTime> _getDaysInCurrentMonth() {
    final now = DateTime.now();
    final selectedYear = _selectedDate.year;
    final selectedMonth = _selectedDate.month;

    final firstDay = DateTime(selectedYear, selectedMonth, 1);
    final lastDay = DateTime(selectedYear, selectedMonth + 1, 0);

    final allDaysInMonth = List.generate(
      lastDay.day,
      (index) => firstDay.add(Duration(days: index)),
    );

    // If it's the current month, filter to show only today and future days
    if (selectedMonth == now.month && selectedYear == now.year) {
      final today = DateTime(now.year, now.month, now.day);
      return allDaysInMonth.where((date) {
        final dateOnly = DateTime(date.year, date.month, date.day);
        return dateOnly.isAtSameMomentAs(today) || dateOnly.isAfter(today);
      }).toList();
    }

    // For future months, show all days
    return allDaysInMonth;
  }

  /// Checks if the given date is selected
  bool _isDateSelected(DateTime date) {
    return date.day == _selectedDate.day &&
        date.month == _selectedDate.month &&
        date.year == _selectedDate.year;
  }

  /// Checks if the given month is selected
  bool _isMonthSelected(int month) {
    return month == _selectedDate.month;
  }

  /// Checks if the given day is enabled based on selected month
  bool _isDayEnabled(DateTime date) {
    final now = DateTime.now();
    final selectedMonth = _selectedDate.month;
    final selectedYear = _selectedDate.year;

    // If it's the current month and year, only enable today and future days
    if (selectedMonth == now.month && selectedYear == now.year) {
      final today = DateTime(now.year, now.month, now.day);
      final dateOnly = DateTime(date.year, date.month, date.day);
      return dateOnly.isAtSameMomentAs(today) || dateOnly.isAfter(today);
    }

    // For future months, all days are enabled
    return true;
  }

  /// Checks if the given month is enabled (current month or future)
  bool _isMonthEnabled(int month) {
    final now = DateTime.now();
    return month >= now.month;
  }

  /// Month names for display
  static const List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}

/// Private widget for selection containers (Days/Months)
class _SelectionContainer extends StatelessWidget {
  final String title;
  final bool isExpanded;
  final VoidCallback onTap;

  const _SelectionContainer({
    required this.title,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: AppColor.lightGrey,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: AppColor.datePickerBorder),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                title,
                style: AppTextStyles.font16Regular,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Transform.rotate(
              angle: isExpanded ? 1.5708 : 0, // 90 degrees if expanded
              child: SvgPicture.asset(Assets.assetsSvgsShowmore),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private widget for grid containers
class _GridContainer extends StatelessWidget {
  final Widget child;

  const _GridContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.divider),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}

/// Private widget for selectable items in grids
class _SelectableItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final VoidCallback? onTap;

  const _SelectableItem({
    required this.text,
    required this.isSelected,
    this.isEnabled = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary
              : isEnabled
              ? Colors.transparent
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? AppColor.primary
                : isEnabled
                ? AppColor.divider
                : Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.font14Regular.copyWith(
              color: isSelected
                  ? Colors.white
                  : isEnabled
                  ? Colors.black
                  : Colors.grey.shade400,
            ),
          ),
        ),
      ),
    );
  }
}
