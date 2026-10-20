import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/features/store/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/configs/di/injection_container.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product_history_bloc/product_history_bloc.dart';
import 'product_add_sctock_widget.dart';

/// Mahsulot zaxirasi tarixi: qachon qancha qo'shilgan, ayirilgan,
/// sotilgan va vozvrat qilingan
Future<void> showProductHistoryPanel(
  BuildContext context, {
  required ProductModel product,
}) {
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => BlocProvider(
      create: (_) =>
          sl<ProductHistoryBloc>()..add(ProductHistoryStarted(pk: product.id)),
      child: ProductHistoryPanel(product: product),
    ),
  );
}

/// Filtrlar: kalit -> backend `type` qiymati
const _filters = {
  'all': '',
  'in': 'initial,add,inv_plus',
  'sale': StockMovementKind.sale,
  'refund': StockMovementKind.refund,
  'out': 'remove,write_off,inv_minus',
};

class ProductHistoryPanel extends StatefulWidget {
  final ProductModel product;

  const ProductHistoryPanel({super.key, required this.product});

  @override
  State<ProductHistoryPanel> createState() => _ProductHistoryPanelState();
}

class _ProductHistoryPanelState extends State<ProductHistoryPanel> {
  String _filter = 'all';

  ProductModel get product => widget.product;

  void _load({int offset = 0}) {
    context.read<ProductHistoryBloc>().add(ProductHistoryStarted(
          pk: product.id,
          type: _filters[_filter]!,
          offset: offset,
        ));
  }

  String _qty(double value) =>
      formatStockWithUnit(value, product.unit, product.packSize);

  @override
  Widget build(BuildContext context) {
    return AppSidePanel(
      title: tr("stock_history"),
      subtitle: product.title,
      icon: Icons.history_rounded,
      iconColor: AppColors.info,
      body: BlocBuilder<ProductHistoryBloc, ProductHistoryState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductSummaryCard(product: product),
              const SizedBox(height: AppSpacing.lg),
              ...state.when(
                initial: () => const [AppLoading()],
                inPrepare: () => const [AppLoading()],
                failure: (error) => [
                  AppErrorState(message: error.message, onRetry: _load),
                ],
                success: (model, loadingMore) => [
                  _SummaryGrid(summary: model.summary, format: _qty),
                  const SizedBox(height: AppSpacing.lg),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: AppSegmentedControl<String>(
                      segments: {
                        for (final key in _filters.keys)
                          key: tr("history_filter_$key"),
                      },
                      value: _filter,
                      onChanged: (value) {
                        setState(() => _filter = value);
                        _load();
                      },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (model.movements.isEmpty)
                    EmptyState(
                      icon: Icons.history_toggle_off_rounded,
                      message: tr("history_empty"),
                    )
                  else
                    for (final m in model.movements)
                      _MovementTile(movement: m, product: product),
                  if (model.hasMore) ...[
                    const SizedBox(height: AppSpacing.md),
                    Center(
                      child: AppButton.secondary(
                        label: tr("load_more"),
                        loading: loadingMore,
                        onPressed: loadingMore
                            ? null
                            : () => _load(offset: model.movements.length),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryGrid extends StatelessWidget {
  final StockSummaryModel summary;
  final String Function(double) format;

  const _SummaryGrid({required this.summary, required this.format});

  @override
  Widget build(BuildContext context) {
    final tiles = [
      AppStatTile(
        label: tr("history_total_in"),
        value: format(summary.totalIn),
        icon: Icons.add_box_rounded,
        color: AppColors.success,
      ),
      AppStatTile(
        label: tr("history_total_sold"),
        value: format(summary.sold),
        icon: Icons.point_of_sale_rounded,
        color: AppColors.info,
      ),
      AppStatTile(
        label: tr("history_total_refund"),
        value: format(summary.refunded),
        icon: Icons.undo_rounded,
        color: AppColors.warning,
      ),
      AppStatTile(
        label: tr("history_total_out"),
        value: format(summary.totalOut),
        icon: Icons.indeterminate_check_box_rounded,
        color: AppColors.danger,
      ),
    ];
    return Column(
      children: [
        for (var i = 0; i < tiles.length; i += 2) ...[
          Row(
            children: [
              Expanded(child: tiles[i]),
              const SizedBox(width: AppSpacing.sm),
              Expanded(child: tiles[i + 1]),
            ],
          ),
          if (i == 0) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _MovementTile extends StatelessWidget {
  final StockMovementModel movement;
  final ProductModel product;

  const _MovementTile({required this.movement, required this.product});

  (IconData, Color) get _look => switch (movement.kind) {
        StockMovementKind.sale => (Icons.point_of_sale_rounded, AppColors.info),
        StockMovementKind.refund => (Icons.undo_rounded, AppColors.warning),
        StockMovementKind.remove ||
        StockMovementKind.writeOff ||
        StockMovementKind.inventoryMinus =>
          (Icons.remove_circle_rounded, AppColors.danger),
        _ => (Icons.add_circle_rounded, AppColors.success),
      };

  String get _quantity {
    final m = movement;
    if (m.kind == StockMovementKind.sale || m.kind == StockMovementKind.refund) {
      final piece = m.pieceQuantity;
      if (piece != null) {
        return saleQuantityLabel(
          quantity: piece,
          unit: product.unit,
          isPieceSale: true,
          packSize: product.packSize,
        );
      }
    }
    return formatStockWithUnit(m.quantity, product.unit, product.packSize);
  }

  String get _details {
    final m = movement;
    final parts = <String>[
      if (m.created != null) DateFormat('dd.MM.yyyy HH:mm').format(m.created!),
      if (m.user.isNotEmpty) m.user,
      if (m.transactionId != null) "${tr("check")} #${m.transactionId}",
      if (m.reason.isNotEmpty) tr("history_reason_${m.reason}"),
      if (m.purchaseType.isNotEmpty) tr("history_purchase"),
    ];
    return parts.join(' · ');
  }

  @override
  Widget build(BuildContext context) {
    final m = movement;
    final (icon, color) = _look;
    final original = m.originalQuantity;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 19, color: color),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr("history_kind_${m.kind}"), style: AppText.bodyStrong),
                Text(_details, style: AppText.caption),
                if (m.note.isNotEmpty)
                  Text(m.note, style: AppText.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
                if (original != null && original > m.quantity)
                  Text(
                    tr("history_partly_refunded", args: [
                      formatStockWithUnit(original, product.unit, product.packSize),
                    ]),
                    style: AppText.caption.copyWith(color: AppColors.warning),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${m.isIncoming ? '+' : '−'}$_quantity",
                style: AppText.bodyStrong.copyWith(color: color),
              ),
              Text(formatCurrency(m.total), style: AppText.caption),
            ],
          ),
        ],
      ),
    );
  }
}
