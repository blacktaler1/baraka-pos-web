import 'package:baraka_pos/features/firma/domain/model/firma_model.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:baraka_pos/shared/design/design.dart';

class FirmaCard extends StatefulWidget {
  final FirmaModel model;

  const FirmaCard({
    super.key,
    required this.model,
  });

  @override
  State<FirmaCard> createState() => _FirmaCardState();
}

class _FirmaCardState extends State<FirmaCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final imageUrl =
        model.images.models.isNotEmpty ? model.images.models.first.file : null;
    final hasDebt = model.remainder > 0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.go(
          "/firma-Information",
          extra: {'firmaId': model.id, 'remainder': model.remainder},
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, _hovered ? -3 : 0, 0),
          clipBehavior: Clip.antiAlias,
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
                blurRadius: _hovered ? 22 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Yuqoridagi yumshoq gradient chiziq
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                height: 64,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.10),
                        AppColors.gold.withValues(alpha: 0.08),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: AppAvatar(
                            name: model.title,
                            imageUrl: imageUrl,
                            size: 54,
                          ),
                        ),
                        const Spacer(),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 160),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: _hovered
                                ? AppColors.primary
                                : AppColors.surface.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_outward_rounded,
                            size: 16,
                            color: _hovered
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      model.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.h3,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(
                          Icons.call_rounded,
                          size: 13,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            model.phone.isEmpty ? "-" : model.phone,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppText.caption,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Divider(height: 1, color: AppColors.border),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.inventory_2_rounded,
                          size: 14,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${model.totalProducts} ${tr("products_to")}",
                          style: AppText.caption.copyWith(
                            color: AppColors.ink,
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                            child: _DebtPill(hasDebt: hasDebt, model: model)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DebtPill extends StatelessWidget {
  final bool hasDebt;
  final FirmaModel model;

  const _DebtPill({required this.hasDebt, required this.model});

  @override
  Widget build(BuildContext context) {
    final color = hasDebt ? AppColors.danger : AppColors.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: hasDebt ? AppColors.dangerSoft : AppColors.successSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            hasDebt ? Icons.error_rounded : Icons.verified_rounded,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              hasDebt
                  ? formatCurrency(model.remainder.toString(),
                      withCurrency: false)
                  : tr("no_debt"),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppText.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
