import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/domain/model/cash_product_model.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import 'product_picker_field.dart';

Future<void> showInventoryCountPanel(BuildContext context, int countId) {
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) => InventoryCountPanel(countId: countId),
  );
}

String _qty(String value) {
  final v = parseAmount(value);
  return v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(3);
}

class InventoryCountPanel extends StatefulWidget {
  final int countId;

  const InventoryCountPanel({super.key, required this.countId});

  @override
  State<InventoryCountPanel> createState() => _InventoryCountPanelState();
}

class _InventoryCountPanelState extends State<InventoryCountPanel> {
  InventoryCountModel? _count;

  bool get _editable => _count?.status == "draft";

  @override
  void initState() {
    super.initState();
    context
        .read<GetInventoryCountBloc>()
        .add(GetInventoryCountStarted(id: widget.countId));
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _update(InventoryCountModel model) {
    if (model.id == widget.countId) setState(() => _count = model);
  }

  void _scan(CashProductModel product) {
    context.read<AddInventoryItemBloc>().add(AddInventoryItemStarted(
          countId: widget.countId,
          productId: product.id,
          countedQuantity: 1,
          mode: "add",
        ));
  }

  void _setCounted(InventoryItemModel item, String value) {
    final qty = parseAmount(value, fallback: -1);
    if (qty < 0) return;
    context.read<AddInventoryItemBloc>().add(AddInventoryItemStarted(
          countId: widget.countId,
          productId: item.productId,
          countedQuantity: qty,
          mode: "set",
        ));
  }

  Future<void> _complete() async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("complete_inventory"),
      message: tr("complete_inventory_hint"),
      confirmLabel: tr("complete_inventory"),
    );
    if (confirmed && mounted) {
      context
          .read<CompleteInventoryCountBloc>()
          .add(CompleteInventoryCountStarted(id: widget.countId));
    }
  }

  Future<void> _cancel() async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("cancel_inventory"),
      confirmLabel: tr("cancel_inventory"),
      danger: true,
    );
    if (confirmed && mounted) {
      context
          .read<CancelInventoryCountBloc>()
          .add(CancelInventoryCountStarted(id: widget.countId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetInventoryCountBloc, GetInventoryCountState>(
          listener: (_, s) =>
              s.whenOrNull(success: _update, failure: (e) => _snack(e.message)),
        ),
        BlocListener<AddInventoryItemBloc, AddInventoryItemState>(
          listener: (_, s) =>
              s.whenOrNull(success: _update, failure: (e) => _snack(e.message)),
        ),
        BlocListener<RemoveInventoryItemBloc, RemoveInventoryItemState>(
          listener: (_, s) =>
              s.whenOrNull(success: _update, failure: (e) => _snack(e.message)),
        ),
        BlocListener<CompleteInventoryCountBloc, CompleteInventoryCountState>(
          listener: (_, s) => s.whenOrNull(
            success: (model) {
              _update(model);
              _snack(tr("inventory_completed"));
            },
            failure: (e) => _snack(e.message),
          ),
        ),
        BlocListener<CancelInventoryCountBloc, CancelInventoryCountState>(
          listener: (_, s) =>
              s.whenOrNull(success: _update, failure: (e) => _snack(e.message)),
        ),
      ],
      child: AppSidePanel(
        title: "${tr("inventory")} #${widget.countId}",
        icon: Icons.fact_check_rounded,
        iconColor: AppColors.info,
        subtitle:
            _count == null ? null : tr("inventory_status_${_count!.status}"),
        body: _count == null
            ? const SizedBox(height: 200, child: AppLoading())
            : _body(_count!),
        actions: [
          if (_editable) ...[
            AppButton.secondary(
              label: tr("cancel_inventory"),
              onPressed: _cancel,
            ),
            AppButton(
              label: tr("complete_inventory"),
              icon: Icons.task_alt_rounded,
              onPressed: _count!.items.models.isEmpty ? null : _complete,
            ),
          ] else
            AppButton.secondary(
              label: tr("close"),
              onPressed: () => Navigator.pop(context),
            ),
        ],
      ),
    );
  }

  Widget _body(InventoryCountModel count) {
    final items = count.items.models;
    final shortage = items.fold<double>(0, (sum, i) {
      final diff = parseAmount(i.difference);
      return diff < 0 ? sum + diff * parseAmount(i.costPrice) : sum;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_editable) ...[
          Text(tr("inventory_scan_hint"), style: AppText.caption),
          const SizedBox(height: AppSpacing.sm),
          ProductPickerField(onSelected: _scan),
          const SizedBox(height: AppSpacing.md),
        ],
        if (!_editable && count.status == "completed" && shortage < 0) ...[
          AppTotalBar(
            label: tr("shortage_cost"),
            value: formatCurrency(shortage.abs().toStringAsFixed(0)),
            color: AppColors.danger,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (items.isEmpty)
          EmptyState(
            icon: Icons.fact_check_rounded,
            message: tr("inventory_empty"),
          )
        else
          AppDataTable(
            columns: [
              tr("products"),
              tr("counted"),
              _editable ? tr("in_stock") : tr("expected"),
              tr("difference"),
              "",
            ],
            numericColumns: const {2, 3},
            rows: [for (final item in items) _row(item)],
          ),
      ],
    );
  }

  DataRow _row(InventoryItemModel item) {
    final diff = parseAmount(item.difference);
    final color = diff == 0
        ? AppColors.textSecondary
        : diff < 0
            ? AppColors.danger
            : AppColors.success;
    return DataRow(cells: [
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.productTitle, style: AppText.bodyStrong),
          Text(item.barcode, style: AppText.caption),
        ],
      )),
      DataCell(_editable
          ? SizedBox(
              width: 100,
              child: TextFormField(
                key: ValueKey("${item.id}-${item.countedQuantity}"),
                initialValue: _qty(item.countedQuantity),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                onFieldSubmitted: (v) => _setCounted(item, v),
              ),
            )
          : Text(_qty(item.countedQuantity), style: AppText.bodyStrong)),
      DataCell(Text(
        _qty(_editable ? item.currentStock : item.expectedQuantity),
        style: AppText.body,
      )),
      DataCell(Text(
        "${diff > 0 ? "+" : ""}${_qty(item.difference)}",
        style: AppText.bodyStrong.copyWith(color: color),
      )),
      DataCell(_editable
          ? AppIconButton(
              icon: Icons.close_rounded,
              tooltip: tr("delete"),
              color: AppColors.textTertiary,
              onPressed: () => context.read<RemoveInventoryItemBloc>().add(
                  RemoveInventoryItemStarted(
                      countId: widget.countId, itemId: item.id)),
            )
          : const SizedBox.shrink()),
    ]);
  }
}
