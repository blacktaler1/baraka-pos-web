import 'package:baraka_pos/features/global/global.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCardWidget extends StatefulWidget {
  final CategoryModel model;

  const CategoryCardWidget({super.key, required this.model});

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  bool _hovered = false;

  // Rasmsiz kategoriyalar uchun bezak ranglari (id bo'yicha barqaror)
  static const _tints = [
    AppColors.primary,
    AppColors.info,
    AppColors.gold,
    AppColors.chartPurchase,
    AppColors.danger,
    AppColors.success,
  ];

  CategoryModel get model => widget.model;

  Future<void> _delete(BuildContext context) async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("delete_category"),
      message: "${tr("are_you_sure_category")} '${model.title}'?",
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (confirmed && context.mounted) {
      context
          .read<DeleteCategoryBloc>()
          .add(DeleteCategoryStarted(pk: model.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tint = _tints[model.id.abs() % _tints.length];

    Widget placeholder() => DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                tint.withValues(alpha: 0.18),
                tint.withValues(alpha: 0.05),
              ],
            ),
          ),
          child: Center(
            child: Icon(Icons.category_rounded, size: 40, color: tint),
          ),
        );

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: _hovered ? AppColors.borderStrong : AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered
                  ? AppColors.ink.withValues(alpha: 0.10)
                  : AppColors.shadow,
              blurRadius: _hovered ? 20 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: model.image.isEmpty
                        ? placeholder()
                        : Image.network(
                            model.image,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => placeholder(),
                          ),
                  ),
                  // Amallar — kursor ustiga kelganda yorqinroq
                  Positioned(
                    top: 6,
                    right: 6,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 160),
                      opacity: _hovered ? 1 : 0.85,
                      child: Row(
                        children: [
                          _RoundAction(
                            icon: Icons.edit_rounded,
                            color: AppColors.info,
                            tooltip: tr("edit"),
                            onTap: () =>
                                showCategoryPanel(context, category: model),
                          ),
                          const SizedBox(width: 6),
                          _RoundAction(
                            icon: Icons.delete_rounded,
                            color: AppColors.danger,
                            tooltip: tr("delete"),
                            onTap: () => _delete(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 4),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: tint,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.h3,
                    ),
                  ),
                  Text(
                    "#${model.id}",
                    style:
                        AppText.caption.copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  const _RoundAction({
    required this.icon,
    required this.color,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: AppColors.surface,
        shape: const CircleBorder(),
        elevation: 2,
        shadowColor: AppColors.ink.withValues(alpha: 0.2),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: SizedBox(
            width: 30,
            height: 30,
            child: Icon(icon, size: 16, color: color),
          ),
        ),
      ),
    );
  }
}
