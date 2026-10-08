import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const SettingsButton({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(178, 37),
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        text,
        style: AppText.bodyMedium.copyWith(color: Colors.white),
      ),
    );
  }
}
