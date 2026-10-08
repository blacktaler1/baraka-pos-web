import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/domain/model/category_model.dart';
import '../../../global/presentation/blocs/get_category_bloc/get_category_bloc.dart';
import 'categories_card.dart';

class CashCategorySection extends StatelessWidget {
  final ScrollController categoryController;
  final String selectedCategory;
  final bool isAtStart;
  final bool isAtEnd;
  final Function(String) onCategorySelect;
  final VoidCallback scrollLeft;
  final VoidCallback scrollRight;

  const CashCategorySection({
    super.key,
    required this.categoryController,
    required this.selectedCategory,
    required this.isAtStart,
    required this.isAtEnd,
    required this.onCategorySelect,
    required this.scrollLeft,
    required this.scrollRight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!context.isMobile) ...[
          AppSectionHeader(
            title: tr("categories"),
            icon: Icons.category_rounded,
            iconColor: AppColors.info,
            // Telefonda kategoriyalar barmoq bilan suriladi
            trailing: context.isMobile
                ? null
                : Row(
                    children: [
                      _RoundArrow(
                        icon: Icons.chevron_left_rounded,
                        onTap: isAtStart ? null : scrollLeft,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      _RoundArrow(
                        icon: Icons.chevron_right_rounded,
                        onTap: isAtEnd ? null : scrollRight,
                      ),
                    ],
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        SizedBox(
          height: context.isMobile ? 42 : 48,
          child: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                inPrepare: () => const AppLoading(),
                failure: (err) => Text(err.message, style: AppText.small),
                success: (model) {
                  final categories = [
                    CategoryModel(id: 0, title: "", image: ""),
                    ...model.collection.models,
                  ];
                  return ListView.separated(
                    controller: categoryController,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(width: AppSpacing.xs),
                    itemBuilder: (context, index) => CategoriesCard(
                      isSelected: categories[index].title == selectedCategory,
                      model: categories[index],
                      onTap: () => onCategorySelect(categories[index].title),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _RoundArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundArrow({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return Material(
      color: enabled ? AppColors.surface : AppColors.surfaceSunken,
      shape: CircleBorder(
        side: BorderSide(
          color: enabled ? AppColors.border : Colors.transparent,
        ),
      ),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 34,
          height: 34,
          child: Icon(
            icon,
            size: 20,
            color: enabled ? AppColors.ink : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}
