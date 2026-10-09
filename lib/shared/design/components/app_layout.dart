import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';
import 'app_button.dart';

class AppPage extends StatelessWidget {
  final Widget? toolbar;
  final Widget child;
  final Widget? footer;

  const AppPage({super.key, this.toolbar, required this.child, this.footer});

  @override
  Widget build(BuildContext context) {
    // Sarlavha ro'yxat bilan birga suriladi (telefon va keng ekranda ham)
    if (toolbar != null) return _buildScrolling(context);
    return ColoredBox(
      color: AppColors.canvas,
      child: Padding(
        padding: EdgeInsets.all(context.pageGutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (toolbar != null) ...[
              toolbar!,
              SizedBox(
                  height: context.isMobile ? AppSpacing.sm : AppSpacing.lg),
            ],
            Expanded(child: child),
            if (footer != null) ...[
              const SizedBox(height: AppSpacing.md),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}

extension on AppPage {
  /// Sarlavha/statistika ro'yxat bilan birga suriladi (NestedScrollView),
  /// shunda ro'yxat uchun butun ekran bo'shaydi
  Widget _buildScrolling(BuildContext context) {
    final gutter = context.pageGutter;
    return ColoredBox(
      color: AppColors.canvas,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverPadding(
                  padding: EdgeInsets.fromLTRB(
                      gutter, gutter, gutter, AppSpacing.sm),
                  sliver: SliverToBoxAdapter(child: toolbar!),
                ),
              ],
              body: Builder(
                // Ichki ro'yxat tashqi skroll bilan bog'lanishi uchun
                // (web/desktop platformalarda ham)
                builder: (context) => PrimaryScrollController(
                  controller: PrimaryScrollController.of(context),
                  automaticallyInheritForPlatforms:
                      TargetPlatform.values.toSet(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: gutter),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
          if (footer != null)
            Padding(
              padding:
                  EdgeInsets.fromLTRB(gutter, AppSpacing.xs, gutter, gutter),
              child: footer!,
            ),
        ],
      ),
    );
  }
}

class AppToolbar extends StatelessWidget {
  final List<Widget> leading;
  final List<Widget> trailing;

  const AppToolbar({
    super.key,
    this.leading = const [],
    this.trailing = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      // Telefonda elementlar qatorga sig'masa keyingi qatorga o'tadi
      return Wrap(
        spacing: AppSpacing.xs,
        runSpacing: AppSpacing.xs,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [...leading, ...trailing],
      );
    }
    return SizedBox(
      height: AppSizes.controlHeight,
      child: Row(
        children: [
          ..._spaced(leading),
          const Spacer(),
          ..._spaced(trailing),
        ],
      ),
    );
  }

  List<Widget> _spaced(List<Widget> items) => [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.sm),
          items[i],
        ],
      ];
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool clip;

  const AppCard({
    super.key,
    required this.child,
    this.padding = AppSpacing.cardPadding,
    this.onTap,
    this.clip = false,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      clipBehavior: clip ? Clip.antiAlias : Clip.none,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.card,
        hoverColor: AppColors.surfaceMuted,
        child: card,
      ),
    );
  }
}

class AppSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color iconColor;
  final Widget? trailing;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor = AppColors.primary,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  iconColor.withValues(alpha: 0.16),
                  iconColor.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: iconColor.withValues(alpha: 0.12)),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppText.h3,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) Text(subtitle!, style: AppText.small),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

enum AppTone { neutral, primary, success, warning, danger, info }

class AppBadge extends StatelessWidget {
  final String text;
  final AppTone tone;
  final IconData? icon;

  const AppBadge(
    this.text, {
    super.key,
    this.tone = AppTone.neutral,
    this.icon,
  });

  (Color, Color) get _colors => switch (tone) {
        AppTone.neutral => (AppColors.textSecondary, AppColors.surfaceSunken),
        AppTone.primary => (AppColors.primary, AppColors.primarySoft),
        AppTone.success => (AppColors.success, AppColors.successSoft),
        AppTone.warning => (AppColors.warning, AppColors.warningSoft),
        AppTone.danger => (AppColors.danger, AppColors.dangerSoft),
        AppTone.info => (AppColors.info, AppColors.infoSoft),
      };

  @override
  Widget build(BuildContext context) {
    final (fg, bg) = _colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: fg.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(text, style: AppText.caption.copyWith(color: fg)),
        ],
      ),
    );
  }
}

class AppTableCard extends StatelessWidget {
  final Widget child;

  const AppTableCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
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

class AppLoading extends StatelessWidget {
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      );
}

class AppErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const AppErrorState({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.danger.withValues(alpha: 0.16),
                    AppColors.danger.withValues(alpha: 0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: AppColors.danger.withValues(alpha: 0.12),
                ),
              ),
              child: const Icon(
                Icons.cloud_off_rounded,
                color: AppColors.danger,
                size: 26,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppText.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.md),
              AppButton.secondary(
                label: tr("refresh"),
                icon: Icons.autorenew_rounded,
                onPressed: onRetry,
                size: AppButtonSize.sm,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<bool> showAppConfirm(
  BuildContext context, {
  required String title,
  String? message,
  required String confirmLabel,
  String? cancelLabel,
  bool danger = false,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: danger ? AppColors.dangerSoft : AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  danger
                      ? Icons.warning_amber_rounded
                      : Icons.help_outline_rounded,
                  color: danger ? AppColors.danger : AppColors.primary,
                  size: 26,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(title, style: AppText.h2),
              if (message != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(message,
                    style: AppText.body.copyWith(
                      color: AppColors.textSecondary,
                    )),
              ],
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton.secondary(
                    label: cancelLabel ?? tr("cancel"),
                    onPressed: () => Navigator.pop(context, false),
                  ),
                  danger
                      ? AppButton.danger(
                          label: confirmLabel,
                          icon: Icons.delete_rounded,
                          onPressed: () => Navigator.pop(context, true),
                        )
                      : AppButton(
                          label: confirmLabel,
                          icon: Icons.check_circle_rounded,
                          onPressed: () => Navigator.pop(context, true),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
  return result ?? false;
}

class AppDataTable extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;
  final Set<int> numericColumns;

  const AppDataTable({
    super.key,
    required this.columns,
    required this.rows,
    this.numericColumns = const {},
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile)
      return _MobileTableCards(columns: columns, rows: rows);
    return AppTableCard(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child: DataTable(
                showCheckboxColumn: false,
                columns: [
                  for (var i = 0; i < columns.length; i++)
                    DataColumn(
                      label: Text(columns[i]),
                      numeric: numericColumns.contains(i),
                    ),
                ],
                rows: rows,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppRowActions extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final List<Widget> extra;

  const AppRowActions({
    super.key,
    this.onEdit,
    this.onDelete,
    this.extra = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...extra,
        if (onEdit != null)
          AppIconButton(
            icon: Icons.edit_rounded,
            tooltip: tr("edit"),
            color: AppColors.info,
            onPressed: onEdit,
          ),
        if (onDelete != null)
          AppIconButton(
            icon: Icons.delete_rounded,
            tooltip: tr("delete"),
            color: AppColors.danger,
            onPressed: onDelete,
          ),
      ],
    );
  }
}

class AppAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double size;

  const AppAvatar({
    super.key,
    required this.name,
    this.imageUrl,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      child: hasImage
          ? Image.network(
              imageUrl!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _initial(),
            )
          : _initial(),
    );
  }

  Widget _initial() => Text(
        name.isNotEmpty ? name.characters.first.toUpperCase() : '',
        style: TextStyle(
          fontFamily: 'Onest',
          fontSize: size * 0.42,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      );
}

class AppStatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const AppStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withValues(alpha: 0.16),
                  color.withValues(alpha: 0.06),
                ],
              ),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppText.small,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: AppText.h3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppSegmentedControl<T> extends StatelessWidget {
  final Map<T, String> segments;
  final T value;
  final ValueChanged<T> onChanged;

  const AppSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final control = _buildControl();
    if (!context.isMobile) return control;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: control,
    );
  }

  Widget _buildControl() {
    return Container(
      height: AppSizes.controlHeight,
      padding: const EdgeInsets.all(AppSpacing.xxs),
      decoration: BoxDecoration(
        color: AppColors.surfaceSunken,
        borderRadius: AppRadius.control,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: segments.entries.map((e) {
          final active = e.key == value;
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => onChanged(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: active ? AppColors.surface : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  boxShadow: active
                      ? const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  e.value,
                  style: AppText.label.copyWith(
                    color: active ? AppColors.ink : AppColors.textSecondary,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AppOptionTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const AppOptionTile({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.primarySoft : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.control,
        side: BorderSide(
          color: selected ? AppColors.primary : AppColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.control,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : AppColors.surfaceSunken,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: selected ? Colors.white : AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: selected ? AppText.bodyStrong : AppText.bodyMedium,
                    ),
                    if (subtitle != null)
                      Text(subtitle!, style: AppText.caption),
                  ],
                ),
              ),
              if (selected)
                const Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.primary,
                  size: AppSizes.icon,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppInfoGrid extends StatelessWidget {
  final List<(String, String)> items;
  final int columns;

  const AppInfoGrid({super.key, required this.items, this.columns = 2});

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < items.length; i += columns) {
      final slice = items.skip(i).take(columns).toList();
      if (rows.isNotEmpty) rows.add(const SizedBox(height: AppSpacing.md));
      rows.add(Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var j = 0; j < columns; j++)
            Expanded(
              child: j < slice.length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(slice[j].$1, style: AppText.caption),
                        const SizedBox(height: 2),
                        Text(slice[j].$2, style: AppText.bodyStrong),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
        ],
      ));
    }
    return AppCard(child: Column(children: rows));
  }
}

class AppLineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final Widget? leading;

  const AppLineItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: AppSpacing.sm),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.bodyMedium),
                Text(subtitle, style: AppText.caption),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(trailing, style: AppText.bodyStrong),
        ],
      ),
    );
  }
}

class AppTotalBar extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const AppTotalBar({
    super.key,
    required this.label,
    required this.value,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withValues(alpha: 0.12),
            color.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: AppRadius.card,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.summarize_rounded, size: 20, color: color),
          const SizedBox(width: AppSpacing.xs),
          Expanded(child: Text(label, style: AppText.bodyMedium)),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerRight,
              child: Text(value, style: AppText.h2.copyWith(color: color)),
            ),
          ),
        ],
      ),
    );
  }
}

/// Kompyuterda bitta qatorda teng ustunlar, telefonda [mobileColumns] ustunli to'r
class AppAdaptiveRow extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final int mobileColumns;

  const AppAdaptiveRow({
    super.key,
    required this.children,
    this.spacing = AppSpacing.md,
    this.mobileColumns = 2,
  });

  @override
  Widget build(BuildContext context) {
    if (!context.isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) SizedBox(width: spacing),
            Expanded(child: children[i]),
          ],
        ],
      );
    }
    const gap = AppSpacing.xs;
    return LayoutBuilder(
      builder: (context, constraints) {
        final width =
            (constraints.maxWidth - gap * (mobileColumns - 1)) / mobileColumns;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [
            for (final child in children) SizedBox(width: width, child: child),
          ],
        );
      },
    );
  }
}

/// Telefon: jadval qatorlari kartochka ko'rinishida.
/// 1-ustun — sarlavha, sarlavhasiz ustun — amallar (o'ng yuqorida),
/// qolganlari "nomi: qiymati" juftliklari.
class _MobileTableCards extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> rows;

  const _MobileTableCards({required this.columns, required this.rows});

  Widget _card(DataRow row) {
    final cells = row.cells;
    int? actionIndex;
    for (var i = cells.length - 1; i > 0; i--) {
      if (i < columns.length && columns[i].trim().isEmpty) {
        actionIndex = i;
        break;
      }
    }
    final onTap =
        row.onSelectChanged == null ? null : () => row.onSelectChanged!(true);

    final content = Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: cells.first.child,
                ),
              ),
              if (actionIndex != null) cells[actionIndex].child,
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          for (var i = 1; i < cells.length; i++)
            if (i != actionIndex)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    Text(
                      i < columns.length ? columns[i] : '',
                      style: AppText.caption
                          .copyWith(color: AppColors.textTertiary),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: DefaultTextStyle.merge(
                          textAlign: TextAlign.right,
                          child: cells[i].child,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Panel ichida (cheksiz balandlik) — oddiy ustun
        if (!constraints.hasBoundedHeight) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < rows.length; i++) ...[
                if (i > 0) const SizedBox(height: AppSpacing.xs),
                _card(rows[i]),
              ],
            ],
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          itemCount: rows.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.xs),
          itemBuilder: (_, i) => _card(rows[i]),
        );
      },
    );
  }
}
