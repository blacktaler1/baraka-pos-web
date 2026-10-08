import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SectionContainer extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final VoidCallback? onViewAll;
  final Widget? trailing;
  final IconData icon;
  final Color iconColor;

  const SectionContainer({
    super.key,
    required this.title,
    required this.content,
    this.subtitle,
    this.onViewAll,
    this.trailing,
    this.icon = Icons.insights_rounded,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.isMobile ? 14 : AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SectionIcon(icon: icon, color: iconColor),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppText.h3,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: AppText.caption
                            .copyWith(color: AppColors.textTertiary),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const Gap(AppSpacing.md),
          const Divider(height: 1, thickness: 1, color: AppColors.border),
          const Gap(AppSpacing.xs),
          content,
        ],
      ),
    );
  }
}

/// Bo'lim sarlavhasi yonidagi yumshoq gradientli ikona
class SectionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const SectionIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 38,
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
