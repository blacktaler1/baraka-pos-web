import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../domain/model/daily_checks_model.dart';

class ProductsTable extends StatelessWidget {
  final DailyChecksModel model;

  const ProductsTable({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final items = model.product.models;
    if (items.isEmpty) {
      return AppCard(
        child: EmptyState(
          icon: Icons.inventory_2_rounded,
          message: tr("not_found"),
        ),
      );
    }
    return AppDataTable(
      columns: [tr("product"), tr("quantity"), tr("unit"), tr("sub_total")],
      numericColumns: const {1, 3},
      rows: items
          .map(
            (item) => DataRow(cells: [
              DataCell(Text(item.productName, style: AppText.bodyMedium)),
              DataCell(Text(item.quantity, style: AppText.body)),
              DataCell(Text(item.unit, style: AppText.small)),
              DataCell(
                Text(formatCurrency(item.totalSales),
                    style: AppText.bodyStrong),
              ),
            ]),
          )
          .toList(),
    );
  }
}
