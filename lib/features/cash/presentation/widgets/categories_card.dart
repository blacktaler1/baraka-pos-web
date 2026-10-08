import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../global/domain/model/category_model.dart';

class CategoriesCard extends StatelessWidget {
  final CategoryModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoriesCard({
    super.key,
    required this.model,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isAll = model.title.isEmpty;

    Widget fallbackIcon() => Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.18)
                : AppColors.primarySoft,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isAll ? Icons.apps_rounded : Icons.sell_rounded,
            size: 16,
            color: isSelected ? Colors.white : AppColors.primary,
          ),
        );

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(22),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 6, AppSpacing.md, 6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: model.image.isEmpty
                        ? fallbackIcon()
                        : Image.network(
                            model.image,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => fallbackIcon(),
                          ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    isAll ? "all_categories".tr() : model.title,
                    style: AppText.bodyMedium.copyWith(
                      color: isSelected ? Colors.white : AppColors.ink,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
