import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatelessWidget {
  final int days;
  final int hours;
  final int minutes;
  final int seconds;

  const CountdownWidget({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    // 3 kundan kam qolsa — ogohlantiruvchi rang
    final urgent = days < 3;
    final color = urgent ? AppColors.danger : AppColors.primary;
    final bg = urgent ? AppColors.dangerSoft : AppColors.primarySoft;

    Widget box(String value, String label) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: color.withValues(alpha: 0.12)),
          ),
          child: Column(
            children: [
              Text(
                value,
                style: AppText.display.copyWith(color: color, fontSize: 26),
              ),
              Text(
                label,
                style: AppText.caption.copyWith(color: color),
              ),
            ],
          ),
        ),
      );
    }

    Widget sep() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            ':',
            style: AppText.h2.copyWith(color: color.withValues(alpha: 0.5)),
          ),
        );

    return Row(
      children: [
        box(days.toString(), tr('days')),
        sep(),
        box(hours.toString().padLeft(2, '0'), tr('hours')),
        sep(),
        box(minutes.toString().padLeft(2, '0'), tr('minutes')),
        sep(),
        box(seconds.toString().padLeft(2, '0'), tr('seconds')),
      ],
    );
  }
}
