import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc/cart_bloc.dart';
import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/features/cash/presentation/widgets/product_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/model/mock_order.dart';

class OrderDetailsPanel extends StatelessWidget {
  final MockOrder? selectedOrder;
  final int lengthItems;
  final Function(int) removeFromOrder;
  final Function(int, double) updateItemQuantity;

  const OrderDetailsPanel({
    super.key,
    required this.selectedOrder,
    required this.lengthItems,
    required this.removeFromOrder,
    required this.updateItemQuantity,
  });

  @override
  Widget build(BuildContext context) {
    final items = selectedOrder?.items ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(
          title: "order_details".tr(),
          trailing:
              AppBadge("${"items".tr()}: $lengthItems", tone: AppTone.primary),
        ),
        const SizedBox(height: AppSpacing.md),
        if (!context.isMobile)
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text("products".tr(), style: AppText.caption)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                  flex: 2, child: Text("price".tr(), style: AppText.caption)),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                  width: 108, child: Text("qty".tr(), style: AppText.caption)),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                flex: 2,
                child: Text("sub_total".tr(),
                    textAlign: TextAlign.right, style: AppText.caption),
              ),
              const SizedBox(width: AppSizes.controlHeightSm + AppSpacing.xs),
            ],
          ),
        const Divider(),
        if (items.isEmpty)
          EmptyState(
            icon: Icons.shopping_basket_rounded,
            message: "empty_cart".tr(),
          ),
        for (final item in items)
          ProductRow(
            key: ValueKey(item.productId),
            id: item.productId,
            title: item.title,
            stock: item.maxQuantity.toString(),
            cash: true,
            price: item.price,
            unit: item.saleUnit,
            stockLabel:
                item.isRoll ? formatRollStock(item.stock, item.packSize) : null,
            modeToggle: item.isRoll ? _RollModeToggle(item: item) : null,
            quantity: item.quantity,
            onDelete: () => removeFromOrder(item.productId),
            updateQuantity: updateItemQuantity,
          ),
      ],
    );
  }
}

/// Rulon qatori: metrlab yoki butun dona sotish tanlovi
class _RollModeToggle extends StatelessWidget {
  final OrderItem item;

  const _RollModeToggle({required this.item});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    Widget chip(String label, bool selected, bool enabled, VoidCallback onTap) {
      final fg = selected
          ? Colors.white
          : enabled
              ? AppColors.ink
              : AppColors.textTertiary;
      return Padding(
        padding: const EdgeInsets.only(right: AppSpacing.xxs),
        child: Material(
          color: selected ? AppColors.primary : AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            side: BorderSide(
              color: selected ? AppColors.primary : AppColors.borderStrong,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            onTap: enabled && !selected ? onTap : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                label,
                style: AppText.caption.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xxs),
      child: Wrap(
        children: [
          chip("${tr("by_meter")} · ${item.packSize} m", item.byPiece, true,
              () => bloc.add(ToggleItemByPieceEvent(item.productId, true))),
          chip(tr("by_piece"), !item.byPiece, item.fullPieces >= 1,
              () => bloc.add(ToggleItemByPieceEvent(item.productId, false))),
        ],
      ),
    );
  }
}
