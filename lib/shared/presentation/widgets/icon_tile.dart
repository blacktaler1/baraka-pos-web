import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';

class IconTile extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;

  const IconTile({
    super.key,
    required this.icon,
    this.size = 40,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.16),
            color.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Icon(icon, color: color, size: size * 0.5),
    );
  }
}
