import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../aplication/configs/app_colors.dart';

class BrandLogo extends StatelessWidget {
  final double size;
  final bool showWordmark;
  final bool inverse;

  const BrandLogo({
    super.key,
    this.size = 36,
    this.showWordmark = true,
    this.inverse = false,
  });

  @override
  Widget build(BuildContext context) {
    final mark = SvgPicture.asset(
      inverse
          ? 'assets/icons/baraka-mark-inverse.svg'
          : 'assets/icons/baraka-mark.svg',
      width: size,
      height: size,
    );
    if (!showWordmark) return mark;
    final wordmarkColor = inverse ? Colors.white : AppColors.ink;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        SizedBox(width: size * 0.3),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Baraka',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: wordmarkColor,
                ),
              ),
              TextSpan(
                text: ' POS',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: wordmarkColor.withValues(alpha: 0.55),
                ),
              ),
            ],
          ),
          style: TextStyle(
            fontFamily: 'Onest',
            fontSize: size * 0.56,
            letterSpacing: -0.4,
            height: 1,
          ),
        ),
      ],
    );
  }
}
