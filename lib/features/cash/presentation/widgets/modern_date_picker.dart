import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

class ModernDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final String? label;
  final Function(DateTime date)? onDateSelected;
  final VoidCallback onReset;

  const ModernDatePicker({
    super.key,
    this.selectedDate,
    this.label,
    this.onDateSelected,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return AppDateField(
      value: selectedDate,
      placeholder: label,
      onSelected: (date) => onDateSelected?.call(date),
      onClear: onReset,
    );
  }
}
