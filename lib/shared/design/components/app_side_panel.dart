import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

Future<T?> showAppSidePanel<T>(
  BuildContext context, {
  required WidgetBuilder builder,
  double width = AppSizes.sidePanelWidth,
}) {
  if (context.isMobile) {
    return Navigator.of(context, rootNavigator: true).push<T>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          backgroundColor: AppColors.surface,
          resizeToAvoidBottomInset: true,
          body: SafeArea(child: Builder(builder: builder)),
        ),
      ),
    );
  }
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: const Color(0x401C1B18),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, _, __) => Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: Material(
          color: AppColors.surface,
          elevation: 0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(left: BorderSide(color: AppColors.border)),
            ),
            child: Builder(builder: builder),
          ),
        ),
      ),
    ),
    transitionBuilder: (context, animation, _, child) {
      final reduceMotion = MediaQuery.of(context).disableAnimations;
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      if (reduceMotion) return FadeTransition(opacity: curved, child: child);
      return SlideTransition(
        position: Tween(begin: const Offset(0.12, 0), end: Offset.zero)
            .animate(curved),
        child: FadeTransition(opacity: curved, child: child),
      );
    },
  );
}

class AppSidePanel extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget body;
  final List<Widget> actions;
  final bool scrollable;
  final IconData? icon;
  final Color iconColor;

  const AppSidePanel({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions = const [],
    this.scrollable = true,
    this.icon,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    final gutter = mobile ? AppSpacing.md : AppSpacing.xl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(
            gutter,
            mobile ? AppSpacing.sm : AppSpacing.lg,
            mobile ? AppSpacing.xs : AppSpacing.md,
            mobile ? AppSpacing.sm : AppSpacing.lg,
          ),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        iconColor.withValues(alpha: 0.16),
                        iconColor.withValues(alpha: 0.06),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(13),
                    border:
                        Border.all(color: iconColor.withValues(alpha: 0.12)),
                  ),
                  child: Icon(icon, color: iconColor, size: 21),
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: mobile ? AppText.h3 : AppText.h2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        subtitle!,
                        style: AppText.small,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.close_rounded, size: AppSizes.icon),
              ),
            ],
          ),
        ),
        Expanded(
          child: scrollable
              ? SingleChildScrollView(
                  padding: EdgeInsets.all(gutter),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: body,
                )
              : Padding(
                  padding: EdgeInsets.all(gutter),
                  child: body,
                ),
        ),
        if (actions.isNotEmpty)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: gutter,
              vertical: mobile ? AppSpacing.sm : AppSpacing.md,
            ),
            decoration: const BoxDecoration(
              color: AppColors.surfaceMuted,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (var i = 0; i < actions.length; i++) ...[
                  if (i > 0) const SizedBox(width: AppSpacing.sm),
                  // Telefonda tugmalar enini teng bo'lishadi
                  mobile ? Expanded(child: actions[i]) : actions[i],
                ],
              ],
            ),
          ),
      ],
    );
  }
}
