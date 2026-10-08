import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

/// Bo'lim sarlavhasi: gradientli ikona + sarlavha + izoh + amallar
class AppPageHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> actions;

  const AppPageHeader({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) return _buildMobile(context);
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: AppSpacing.md),
        ],
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
            ),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 26),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppText.h1,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style:
                      AppText.caption.copyWith(color: AppColors.textTertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
        for (var i = 0; i < actions.length; i++) ...[
          const SizedBox(width: AppSpacing.sm),
          actions[i],
        ],
      ],
    );
  }
}

extension on AppPageHeader {
  /// Telefon: ixcham sarlavha, amallar pastki qatorga o'raladi
  Widget _buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: AppSpacing.sm),
            ],
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: AppText.h2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppText.caption
                          .copyWith(color: AppColors.textTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
        if (actions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: actions,
          ),
        ],
      ],
    );
  }
}

/// Yumshoq gradient fonli rangli ikona plitkasi
class AppSoftIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const AppSoftIcon({
    super.key,
    required this.icon,
    this.color = AppColors.primary,
    this.size = 44,
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

/// Soyali, yumaloq burchakli oq karta
class AppSoftCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const AppSoftCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.lg),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
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
      child: child,
    );
  }
}

/// Sarlavha oldidagi dumaloq "orqaga" tugmasi
class AppBackButton extends StatelessWidget {
  final VoidCallback onTap;
  final String? tooltip;

  const AppBackButton({super.key, required this.onTap, this.tooltip});

  @override
  Widget build(BuildContext context) {
    final button = Material(
      color: AppColors.surface,
      shape: const CircleBorder(side: BorderSide(color: AppColors.border)),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: const SizedBox.square(
          dimension: 40,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 20,
            color: AppColors.ink,
          ),
        ),
      ),
    );
    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
