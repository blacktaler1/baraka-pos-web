import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

Future<void> showRefundDetailPanel(
    BuildContext context, GetRefundModel refund) {
  return showAppSidePanel(
    context,
    builder: (_) => RefundDetailModal(refund: refund),
  );
}

class RefundDetailModal extends StatelessWidget {
  final GetRefundModel refund;

  const RefundDetailModal({super.key, required this.refund});

  @override
  Widget build(BuildContext context) {
    final items = refund.items.models;
    final quantity = double.parse(refund.totalNum);
    return AppSidePanel(
      title: tr("refund_details"),
      icon: Icons.assignment_return_rounded,
      iconColor: AppColors.danger,
      subtitle: "${tr("refund_id")} #${refund.id}",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.warningSoft,
              borderRadius: AppRadius.card,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: AppSizes.icon,
                  color: AppColors.warning,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr("reason"), style: AppText.caption),
                      Text(
                        refund.description.isEmpty
                            ? tr("unknown")
                            : refund.description,
                        style: AppText.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          AppInfoGrid(items: [
            (tr("real_buy_id"), refund.transactionId),
            (tr("date"), formatDateTime(refund.created)),
            (
              tr("total_quantity"),
              "${quantity == quantity.roundToDouble() ? quantity.toInt() : quantity} ${tr("dona")}"
            ),
            (tr("cashier_name"), refund.cashier.name),
          ]),
          const SizedBox(height: AppSpacing.xl),
          Text(tr("products_list"), style: AppText.h3),
          const SizedBox(height: AppSpacing.xs),
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(),
            AppLineItem(
              title: items[i].productTitle,
              subtitle: "${tr("quantity")}: ${items[i].quantity}",
              trailing: formatCurrency(items[i].subtotal.toString()),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppTotalBar(
            label: tr("refund_amount"),
            value: formatCurrency(refund.totalPrice),
            color: AppColors.danger,
          ),
        ],
      ),
      actions: [
        AppButton.secondary(
          label: tr("close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
