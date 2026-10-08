import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

class ModernDateRangePicker extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final Function(DateTime start, DateTime end)? onRangeSelected;
  final VoidCallback onReset;

  const ModernDateRangePicker({
    super.key,
    this.fromDate,
    this.toDate,
    this.onRangeSelected,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return AppDateRangeField(
      from: fromDate,
      to: toDate,
      onSelected: (start, end) => onRangeSelected?.call(start, end),
      onClear: onReset,
    );
  }
}
