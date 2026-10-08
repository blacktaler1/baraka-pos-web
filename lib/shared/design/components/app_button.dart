import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

enum AppButtonSize { md, sm }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final bool loading;
  final bool expand;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.loading = false,
    this.expand = false,
  });

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.size = AppButtonSize.md,
    this.loading = false,
    this.expand = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.size = AppButtonSize.md,
    this.loading = false,
    this.expand = false,
  }) : variant = AppButtonVariant.ghost;

  const AppButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.size = AppButtonSize.md,
    this.loading = false,
    this.expand = false,
  }) : variant = AppButtonVariant.danger;

  Color get _foreground => switch (variant) {
        AppButtonVariant.primary || AppButtonVariant.danger => Colors.white,
        AppButtonVariant.secondary => AppColors.ink,
        AppButtonVariant.ghost => AppColors.primary,
      };

  @override
  Widget build(BuildContext context) {
    final height = size == AppButtonSize.md
        ? AppSizes.controlHeight
        : AppSizes.controlHeightSm;
    final style = ButtonStyle(
      minimumSize: WidgetStateProperty.all(Size(0, height)),
      padding: WidgetStateProperty.all(
        EdgeInsets.symmetric(
          horizontal: size == AppButtonSize.md ? AppSpacing.md : AppSpacing.sm,
        ),
      ),
      textStyle: WidgetStateProperty.all(
        size == AppButtonSize.md ? AppText.bodyStrong : AppText.label,
      ),
    );

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading)
          const SizedBox.square(
            dimension: AppSizes.iconSm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          )
        else if (icon != null)
          Icon(icon, size: AppSizes.icon - 2),
        if (loading || icon != null) const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );

    final callback = loading ? null : onPressed;
    final Widget button = switch (variant) {
      AppButtonVariant.primary =>
        ElevatedButton(onPressed: callback, style: style, child: content),
      AppButtonVariant.danger => ElevatedButton(
          onPressed: callback,
          style: style.copyWith(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.surfaceSunken;
              }
              if (states.contains(WidgetState.hovered)) {
                return const Color(0xFF9E3129);
              }
              return AppColors.danger;
            }),
          ),
          child: content,
        ),
      AppButtonVariant.secondary =>
        OutlinedButton(onPressed: callback, style: style, child: content),
      AppButtonVariant.ghost =>
        TextButton(onPressed: callback, style: style, child: content),
    };

    return IconTheme.merge(
      data: IconThemeData(color: callback == null ? null : _foreground),
      child: expand ? SizedBox(width: double.infinity, child: button) : button,
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;

  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final button = SizedBox.square(
      dimension: AppSizes.controlHeightSm,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: AppSizes.icon, color: color),
      ),
    );
    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
