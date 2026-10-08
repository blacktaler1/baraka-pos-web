import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

class SettingsRow extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsRow({
    super.key,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Container(
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          color: AppColors.border,
          child: Text(
            label,
            style: AppText.bodyMedium,
          ),
        ),
        child,
      ],
    );
  }
}
