import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/model/mock_order.dart';
import 'order_list_widget.dart';

class OrderListPanel extends StatelessWidget {
  final List<MockOrder> mockOrders;
  final int selectedId;
  final VoidCallback addNewOrder;
  final Function(int) onOrderSelect;
  final Function(int) onOrderDelete;

  const OrderListPanel({
    super.key,
    required this.mockOrders,
    required this.selectedId,
    required this.addNewOrder,
    required this.onOrderSelect,
    required this.onOrderDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(
          title: "order_list".tr(),
          trailing: AppButton.secondary(
            label: "add_new_order".tr(),
            icon: Icons.add_rounded,
            size: AppButtonSize.sm,
            onPressed: addNewOrder,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final order in mockOrders)
              OrderListWidget(
                mockOrder: order,
                isSelected: order.transactionId == selectedId,
                orderListSelected: () => onOrderSelect(order.transactionId),
                orderListDelete: () => onOrderDelete(order.transactionId),
              ),
          ],
        ),
      ],
    );
  }
}
