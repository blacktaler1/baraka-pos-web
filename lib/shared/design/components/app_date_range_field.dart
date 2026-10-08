import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

class AppDateRangeField extends StatelessWidget {
  final DateTime? from;
  final DateTime? to;
  final void Function(DateTime start, DateTime end) onSelected;
  final VoidCallback onClear;

  const AppDateRangeField({
    super.key,
    required this.from,
    required this.to,
    required this.onSelected,
    required this.onClear,
  });

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1),
      initialDateRange: from != null && to != null
          ? DateTimeRange(start: from!, end: to!)
          : null,
    );
    if (range != null) onSelected(range.start, range.end);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = from != null && to != null;
    final format = DateFormat('dd.MM.yyyy');
    final label = hasValue
        ? "${format.format(from!)} – ${format.format(to!)}"
        : tr("date_range");

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.control,
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => _pick(context),
        borderRadius: AppRadius.control,
        child: SizedBox(
          height: AppSizes.controlHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  label,
                  style: AppText.body.copyWith(
                    color: hasValue ? AppColors.ink : AppColors.textTertiary,
                  ),
                ),
                if (hasValue)
                  IconButton(
                    onPressed: onClear,
                    tooltip: tr("clear"),
                    icon:
                        const Icon(Icons.close_rounded, size: AppSizes.iconSm),
                  )
                else
                  const SizedBox(width: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppDateField extends StatelessWidget {
  final DateTime? value;
  final String? placeholder;
  final ValueChanged<DateTime> onSelected;
  final VoidCallback onClear;

  const AppDateField({
    super.key,
    required this.value,
    required this.onSelected,
    required this.onClear,
    this.placeholder,
  });

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) onSelected(picked);
  }

  @override
  Widget build(BuildContext context) {
    final hasValue = value != null;
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.control,
        side: const BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () => _pick(context),
        borderRadius: AppRadius.control,
        child: SizedBox(
          height: AppSizes.controlHeight,
          child: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  hasValue
                      ? DateFormat('dd.MM.yyyy').format(value!)
                      : (placeholder ?? tr("select_date")),
                  style: AppText.body.copyWith(
                    color: hasValue ? AppColors.ink : AppColors.textTertiary,
                  ),
                ),
                if (hasValue)
                  IconButton(
                    onPressed: onClear,
                    tooltip: tr("clear"),
                    icon:
                        const Icon(Icons.close_rounded, size: AppSizes.iconSm),
                  )
                else
                  const SizedBox(width: AppSpacing.sm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
