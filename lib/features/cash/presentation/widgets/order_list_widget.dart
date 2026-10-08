import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../domain/model/mock_order.dart';

class OrderListWidget extends StatelessWidget {
  final MockOrder mockOrder;
  final VoidCallback orderListSelected;
  final VoidCallback orderListDelete;
  final bool isSelected;

  const OrderListWidget({
    super.key,
    required this.mockOrder,
    required this.orderListSelected,
    required this.isSelected,
    required this.orderListDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.primarySoft : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.control,
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: orderListSelected,
        borderRadius: AppRadius.control,
        child: SizedBox(
          height: AppSizes.controlHeightSm,
          child: Padding(
            padding: const EdgeInsets.only(left: AppSpacing.sm),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.receipt_rounded,
                  size: AppSizes.iconSm,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.xxs),
                Text(
                  "${tr("order_id")} ${mockOrder.transactionId}",
                  style: (isSelected ? AppText.bodyStrong : AppText.bodyMedium)
                      .copyWith(fontSize: 13),
                ),
                IconButton(
                  onPressed: orderListDelete,
                  tooltip: tr("delete"),
                  icon: const Icon(Icons.close_rounded, size: AppSizes.iconSm),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
