import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../cash/domain/model/_model.dart';
import '../../../cash/presentation/widgets/transaction_detail_modal.dart';

class PeriodToolbar extends StatelessWidget {
  final String period;
  final ValueChanged<String> onPeriodChanged;
  final String title;
  final IconData icon;

  const PeriodToolbar({
    super.key,
    required this.period,
    required this.onPeriodChanged,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AppPageHeader(
      leading: AppBackButton(
        tooltip: tr("back"),
        onTap: () => Navigator.pop(context),
      ),
      icon: icon,
      title: title,
      actions: [
        AppSegmentedControl<String>(
          segments: {
            "day": tr("day"),
            "week": tr("week"),
            "month": tr("month"),
            "year": tr("year"),
          },
          value: period,
          onChanged: onPeriodChanged,
        ),
      ],
    );
  }
}

class PeriodTransactionsTable extends StatelessWidget {
  final List<TransactionModel> transactions;
  final bool showProfit;

  const PeriodTransactionsTable({
    super.key,
    required this.transactions,
    this.showProfit = false,
  });

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return AppCard(
        child: EmptyState(
          icon: Icons.receipt_long_rounded,
          message: tr("no_data_available"),
        ),
      );
    }
    return AppDataTable(
      columns: [
        tr("receipt_no"),
        tr("date"),
        tr("select_payment"),
        tr("quantity"),
        showProfit ? tr("profit") : tr("price"),
        "",
      ],
      numericColumns: const {3, 4},
      rows: transactions.map((tx) => _row(context, tx)).toList(),
    );
  }

  DataRow _row(BuildContext context, TransactionModel tx) {
    final profit = double.tryParse(tx.profit) ?? 0;
    final Widget value = showProfit
        ? Text(
            "${profit > 0 ? "+" : ""}${formatCurrency(profit.toStringAsFixed(0))}",
            style: AppText.bodyStrong.copyWith(
              color: profit >= 0 ? AppColors.success : AppColors.danger,
            ),
          )
        : Text(formatCurrency(tx.totalSum), style: AppText.bodyStrong);

    return DataRow(
      cells: [
        DataCell(Text("#${tx.transactionId}", style: AppText.bodyMedium)),
        DataCell(Text(formatDateTime(tx.created), style: AppText.small)),
        DataCell(AppBadge(tr(tx.paymentMethod))),
        DataCell(Text(tx.totalQuantity, style: AppText.body)),
        DataCell(value),
        DataCell(
          AppIconButton(
            icon: Icons.visibility_rounded,
            tooltip: tr("view_details"),
            onPressed: () => showTransactionDetailPanel(context, tx),
          ),
        ),
      ],
    );
  }
}
