import 'package:baraka_pos/shared/design/design.dart';
// 3.1 Kam zaxirali mahsulotlar (O'ng taraf tepa)
import 'package:baraka_pos/features/home/presentation/blocs/blocs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'section_conatianer_widget.dart';

class LowStockSection extends StatelessWidget {
  const LowStockSection({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return SectionContainer(
      title: tr("low_stock_products"),
      icon: Icons.inventory_rounded,
      iconColor: AppColors.warning,
      content: BlocBuilder<LowStockBloc, LowStockState>(
        builder: (context, state) {
          return state.when(
            initial: () => const _SectionLoading(),
            inPrepare: () => const _SectionLoading(),
            failure: (err) => EmptyState(
              icon: Icons.error_outline_rounded,
              message: tr("error"),
            ),
            success: (model) {
              final products = model.collection.models;
              if (products.isEmpty) {
                return EmptyState(
                  icon: Icons.task_alt_rounded,
                  message: tr("not_item"),
                );
              }

              return Column(
                children: products.map((item) {
                  final stock = double.tryParse(item.stock) ?? 0;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                    child: Row(
                      children: [
                        AppAvatar(
                          name: item.title,
                          size: 40,
                          imageUrl: item.imageCollection.models.isNotEmpty
                              ? item.imageCollection.models.last.file
                              : null,
                        ),
                        const Gap(AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: AppText.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text("ID #${item.id}", style: AppText.caption),
                            ],
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        _StockPill(stock: stock, raw: item.stock),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}

class _StockPill extends StatelessWidget {
  final double stock;
  final String raw;

  const _StockPill({required this.stock, required this.raw});

  @override
  Widget build(BuildContext context) {
    // Zaxira tugagan — xavfli, oz qolgan — ogohlantirish
    final out = stock <= 0;
    final color = out ? AppColors.danger : AppColors.warning;
    final bg = out ? AppColors.dangerSoft : AppColors.warningSoft;
    final text =
        stock == stock.roundToDouble() ? stock.toInt().toString() : raw;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            out
                ? Icons.remove_shopping_cart_rounded
                : Icons.inventory_2_rounded,
            size: 13,
            color: color,
          ),
          const Gap(5),
          Text(
            text,
            style: AppText.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  const _SectionLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.5),
        ),
      ),
    );
  }
}
