import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'product_actions_row.dart';

class ProductsDataTable extends StatelessWidget {
  final List<ProductModel> products;
  final int firmaId;

  const ProductsDataTable({
    super.key,
    required this.products,
    this.firmaId = 0,
  });

  String _money(String v) =>
      formatCurrency(double.tryParse(v)?.toStringAsFixed(0) ?? v,
          withCurrency: false);

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return AppCard(
        child: EmptyState(
          icon: Icons.inventory_2_rounded,
          message: tr("not_item"),
        ),
      );
    }
    return AppDataTable(
      columns: [
        tr("product_name"),
        tr("cost_price"),
        tr("sale_price"),
        tr("margin"),
        tr("stock"),
        tr("unit"),
        "",
      ],
      numericColumns: const {1, 2, 3},
      rows: products.map((p) => _row(p)).toList(),
    );
  }

  DataRow _row(ProductModel p) {
    final imageUrl = p.imageCollection.models.isNotEmpty
        ? p.imageCollection.models.last.file
        : null;
    final cost = double.tryParse(p.cost) ?? 0;
    final margin = (double.tryParse(p.price) ?? 0) - cost;
    final marginPct = cost > 0 ? margin / cost * 100 : null;
    final title = p.unit == "pack"
        ? "${p.title} (${p.packSize})"
        : isRollUnit(p.unit)
            ? "${p.title} (${p.packSize} m)"
            : p.title;
    final category = p.category.title;

    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAvatar(name: p.title, imageUrl: imageUrl, size: 38),
              const SizedBox(width: AppSpacing.sm),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 240),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.bodyStrong,
                    ),
                    Text(
                      category.isEmpty ? "#${p.id}" : "#${p.id} · $category",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption
                          .copyWith(color: AppColors.textTertiary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DataCell(Text(
          _money(p.cost),
          style: AppText.body.copyWith(color: AppColors.textSecondary),
        )),
        DataCell(Text(_money(p.price), style: AppText.bodyStrong)),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_money(margin.toString()), style: AppText.bodyMedium),
              if (marginPct != null) ...[
                const SizedBox(width: AppSpacing.xs),
                _MarginPill(pct: marginPct),
              ],
            ],
          ),
        ),
        DataCell(StockStatusPill(
          stock: p.stock,
          minStock: p.minStock,
          label:
              isRollUnit(p.unit) ? formatRollStock(p.stock, p.packSize) : null,
        )),
        DataCell(
          Text(
            unitLabel(p.unit),
            style: AppText.small,
          ),
        ),
        DataCell(ProductActionsMenu(product: p, firmaId: firmaId)),
      ],
    );
  }
}

class _MarginPill extends StatelessWidget {
  final double pct;

  const _MarginPill({required this.pct});

  @override
  Widget build(BuildContext context) {
    final positive = pct >= 0;
    final color = positive ? AppColors.success : AppColors.danger;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: positive ? AppColors.successSoft : AppColors.dangerSoft,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            positive ? Icons.north_east_rounded : Icons.south_east_rounded,
            size: 11,
            color: color,
          ),
          const SizedBox(width: 2),
          Text(
            "${pct.abs().toStringAsFixed(0)}%",
            style: AppText.caption.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

/// Qoldiq holati: tugagan (qizil), minimal qoldiqdan kam (sariq), yetarli (yashil)
class StockStatusPill extends StatelessWidget {
  final String stock;
  final String minStock;

  /// Raqam o'rniga ko'rsatiladigan yozuv (rulon: "1 dona + 33 m")
  final String? label;

  const StockStatusPill({
    super.key,
    required this.stock,
    this.minStock = "",
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    final value = double.tryParse(stock) ?? 0;
    final min = double.tryParse(minStock) ?? 0;
    final out = value <= 0;
    final low = !out && min > 0 && value <= min;

    final Color color;
    final Color bg;
    final IconData icon;
    final String tooltip;
    if (out) {
      color = AppColors.danger;
      bg = AppColors.dangerSoft;
      icon = Icons.remove_shopping_cart_rounded;
      tooltip = tr("stock_out");
    } else if (low) {
      color = AppColors.warning;
      bg = AppColors.warningSoft;
      icon = Icons.warning_amber_rounded;
      tooltip = tr("stock_low");
    } else {
      color = AppColors.success;
      bg = AppColors.successSoft;
      icon = Icons.check_circle_rounded;
      tooltip = tr("in_stock");
    }

    final text = value == value.roundToDouble()
        ? value.toInt().toString()
        : value.toString();

    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 13, color: color),
            const SizedBox(width: 5),
            Text(
              label ?? text,
              style: AppText.caption.copyWith(
                color: color,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
