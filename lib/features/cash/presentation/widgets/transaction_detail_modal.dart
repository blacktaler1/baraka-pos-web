import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/receipt_share.dart';
import '../../domain/model/transaction_model.dart';

Future<void> showTransactionDetailPanel(
  BuildContext context,
  TransactionModel transaction,
) {
  return showAppSidePanel(
    context,
    builder: (_) => TransactionDetailModal(transaction: transaction),
  );
}

String formatDateTime(String? dateStr) {
  if (dateStr == null || dateStr.isEmpty) return tr("unknown");
  final date = DateTime.tryParse(dateStr);
  return date != null
      ? DateFormat('dd.MM.yyyy HH:mm').format(date.toLocal())
      : dateStr;
}

class TransactionDetailModal extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailModal({super.key, required this.transaction});

  Future<void> _print(BuildContext context) =>
      showReceiptShareSheet(context, transaction);

  @override
  Widget build(BuildContext context) {
    final items = transaction.items.models;
    return AppSidePanel(
      title: tr("transaction_details"),
      icon: Icons.receipt_long_rounded,
      iconColor: AppColors.info,
      subtitle: "ID #${transaction.id}",
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppInfoGrid(items: [
            (tr("receipt_no"), transaction.transactionId),
            (tr("date"), formatDateTime(transaction.created)),
            (
              tr("total_quantity"),
              "${transaction.totalQuantity} ${tr("dona")}"
            ),
            (tr("cashier_name"), transaction.cashier.name),
          ]),
          const SizedBox(height: AppSpacing.xl),
          Text(tr("products_list"), style: AppText.h3),
          const SizedBox(height: AppSpacing.xs),
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const Divider(),
            AppLineItem(
              title: items[i].productTitle,
              subtitle: "${items[i].quantity} ${tr("dona")}",
              trailing: formatCurrency(items[i].subtotal.toString()),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppTotalBar(
            label: tr("total_payment"),
            value: formatCurrency(transaction.totalSum),
          ),
        ],
      ),
      actions: [
        AppButton.secondary(
          label: tr("close"),
          onPressed: () => Navigator.pop(context),
        ),
        AppButton(
          label: tr("send_pdf"),
          icon: Icons.ios_share_rounded,
          onPressed: () => _print(context),
        ),
      ],
    );
  }
}
