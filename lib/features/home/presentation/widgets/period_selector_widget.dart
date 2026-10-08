import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PeriodSelector extends StatelessWidget {
  final String currentPeriod;
  final Function(String) onSelected;

  const PeriodSelector({
    super.key,
    required this.currentPeriod,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    context.locale;
    return AppSegmentedControl<String>(
      segments: {
        "day": tr("day"),
        "week": tr("week"),
        "month": tr("month"),
        "year": tr("year"),
      },
      value: currentPeriod,
      onChanged: onSelected,
    );
  }
}
