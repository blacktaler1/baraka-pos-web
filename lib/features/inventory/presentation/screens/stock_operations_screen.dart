import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/blocs/cash_product_bloc/cash_product_bloc.dart';
import '../../../cash/presentation/widgets/transaction_detail_modal.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import '../widgets/widgets.dart';

enum StockTab { receipts, writeOffs, inventory }

const _pageSize = 100;

class StockOperationsScreen extends StatefulWidget {
  const StockOperationsScreen({super.key});

  @override
  State<StockOperationsScreen> createState() => _StockOperationsScreenState();
}

class _StockOperationsScreenState extends State<StockOperationsScreen> {
  StockTab _tab = StockTab.receipts;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadTab();
  }

  void _loadProducts() {
    context.read<CashProductBloc>().add(
          CashProductStarted(
              search: "", cursor: "", pageSize: "all", category: ""),
        );
  }

  void _loadTab() {
    switch (_tab) {
      case StockTab.receipts:
        context
            .read<GetReceiptsBloc>()
            .add(const GetReceiptsStarted(cursor: "", pageSize: _pageSize));
      case StockTab.writeOffs:
        context
            .read<GetWriteOffsBloc>()
            .add(const GetWriteOffsStarted(cursor: "", pageSize: _pageSize));
      case StockTab.inventory:
        context.read<GetInventoryCountsBloc>().add(
            const GetInventoryCountsStarted(cursor: "", pageSize: _pageSize));
    }
  }

  void _afterStockChange() {
    _loadProducts();
    _loadTab();
  }

  void _create() {
    switch (_tab) {
      case StockTab.receipts:
        showReceiptFormPanel(context);
      case StockTab.writeOffs:
        showWriteOffFormPanel(context);
      case StockTab.inventory:
        context
            .read<CreateInventoryCountBloc>()
            .add(const CreateInventoryCountStarted(note: ""));
    }
  }

  String get _createLabel => switch (_tab) {
        StockTab.receipts => tr("new_receipt"),
        StockTab.writeOffs => tr("new_write_off"),
        StockTab.inventory => tr("new_inventory"),
      };

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateReceiptBloc, CreateReceiptState>(
          listener: (_, s) => s.whenOrNull(success: (_) => _afterStockChange()),
        ),
        BlocListener<CreateWriteOffBloc, CreateWriteOffState>(
          listener: (_, s) => s.whenOrNull(success: (_) => _afterStockChange()),
        ),
        BlocListener<CreateInventoryCountBloc, CreateInventoryCountState>(
          listener: (context, s) => s.whenOrNull(
            success: (count) {
              _loadTab();
              showInventoryCountPanel(context, count.id);
            },
            failure: (e) => ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.message))),
          ),
        ),
        BlocListener<CompleteInventoryCountBloc, CompleteInventoryCountState>(
          listener: (_, s) => s.whenOrNull(success: (_) => _afterStockChange()),
        ),
        BlocListener<CancelInventoryCountBloc, CancelInventoryCountState>(
          listener: (_, s) => s.whenOrNull(success: (_) => _loadTab()),
        ),
      ],
      child: AppPage(
        toolbar: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppPageHeader(
              icon: Icons.compare_arrows_rounded,
              title: tr("stock_operations"),
              actions: [
                AppIconButton(
                  icon: Icons.autorenew_rounded,
                  tooltip: tr("refresh"),
                  onPressed: _loadTab,
                ),
                AppButton(
                  label: _createLabel,
                  icon: switch (_tab) {
                    StockTab.receipts => Icons.move_to_inbox_rounded,
                    StockTab.writeOffs => Icons.outbox_rounded,
                    StockTab.inventory => Icons.fact_check_rounded,
                  },
                  onPressed: _create,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            AppToolbar(
              leading: [
                AppSegmentedControl<StockTab>(
                  segments: {
                    StockTab.receipts: tr("receipts"),
                    StockTab.writeOffs: tr("write_offs"),
                    StockTab.inventory: tr("inventory"),
                  },
                  value: _tab,
                  onChanged: (tab) {
                    setState(() => _tab = tab);
                    _loadTab();
                  },
                ),
              ],
            ),
          ],
        ),
        child: switch (_tab) {
          StockTab.receipts => _ReceiptsTable(onRetry: _loadTab),
          StockTab.writeOffs => _WriteOffsTable(onRetry: _loadTab),
          StockTab.inventory => _InventoryTable(onRetry: _loadTab),
        },
      ),
    );
  }
}

String _money(String value) =>
    formatCurrency(parseAmount(value).toStringAsFixed(0), withCurrency: false);

String _qty(String value) {
  final v = parseAmount(value);
  return v == v.roundToDouble() ? v.toInt().toString() : v.toStringAsFixed(3);
}

Widget _empty(IconData icon, String key) =>
    AppCard(child: EmptyState(icon: icon, message: tr(key)));

class _ReceiptsTable extends StatelessWidget {
  final VoidCallback onRetry;

  const _ReceiptsTable({required this.onRetry});

  void _showDetails(BuildContext context, ReceiptModel receipt) {
    showAppSidePanel(
      context,
      builder: (_) => AppSidePanel(
        title: "${tr("receipt")} #${receipt.id}",
        icon: Icons.move_to_inbox_rounded,
        iconColor: AppColors.success,
        subtitle: formatDateTime(receipt.created),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppInfoGrid(items: [
              (
                tr("company"),
                receipt.firmaTitle.isEmpty ? "—" : receipt.firmaTitle
              ),
              (tr("employee"), receipt.userName),
              (tr("paid_amount"), formatCurrency(receipt.paidAmount)),
              (tr("debt"), formatCurrency(receipt.debt)),
            ]),
            if (receipt.note.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Text(receipt.note, style: AppText.body),
            ],
            const SizedBox(height: AppSpacing.md),
            for (final item in receipt.items.models)
              AppLineItem(
                title: item.productTitle,
                subtitle:
                    "${_qty(item.quantity)} × ${_money(item.unitCost)}${item.newPrice.isEmpty ? "" : " · ${tr("new_sale_price")}: ${_money(item.newPrice)}"}",
                trailing: formatCurrency(item.totalCost),
              ),
            const SizedBox(height: AppSpacing.md),
            AppTotalBar(
              label: tr("grand_total"),
              value: formatCurrency(receipt.totalCost),
            ),
          ],
        ),
        actions: [
          AppButton.secondary(
            label: tr("close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReceiptsBloc, GetReceiptsState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        inPrepare: () => const AppLoading(),
        failure: (e) => AppErrorState(message: e.message, onRetry: onRetry),
        success: (model) {
          final list = model.data.models;
          if (list.isEmpty) {
            return _empty(Icons.move_to_inbox_rounded, "no_receipts");
          }
          return AppDataTable(
            columns: [
              "#",
              tr("date"),
              tr("company"),
              tr("products"),
              tr("grand_total"),
              tr("paid_amount"),
              tr("debt"),
              tr("employee"),
            ],
            numericColumns: const {3, 4, 5, 6},
            rows: [
              for (final r in list)
                DataRow(
                  onSelectChanged: (_) => _showDetails(context, r),
                  cells: [
                    DataCell(Text("${r.id}", style: AppText.bodyStrong)),
                    DataCell(
                        Text(formatDateTime(r.created), style: AppText.body)),
                    DataCell(Text(r.firmaTitle.isEmpty ? "—" : r.firmaTitle,
                        style: AppText.body)),
                    DataCell(
                        Text("${r.items.models.length}", style: AppText.body)),
                    DataCell(
                        Text(_money(r.totalCost), style: AppText.bodyStrong)),
                    DataCell(Text(_money(r.paidAmount), style: AppText.body)),
                    DataCell(parseAmount(r.debt) > 0
                        ? AppBadge(_money(r.debt), tone: AppTone.danger)
                        : const Text("—")),
                    DataCell(Text(r.userName, style: AppText.body)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _WriteOffsTable extends StatelessWidget {
  final VoidCallback onRetry;

  const _WriteOffsTable({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetWriteOffsBloc, GetWriteOffsState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        inPrepare: () => const AppLoading(),
        failure: (e) => AppErrorState(message: e.message, onRetry: onRetry),
        success: (model) {
          final list = model.data.models;
          if (list.isEmpty) {
            return _empty(Icons.delete_sweep_rounded, "no_write_offs");
          }
          return AppDataTable(
            columns: [
              tr("date"),
              tr("products"),
              tr("qty"),
              tr("reason"),
              tr("grand_total"),
              tr("note"),
              tr("employee"),
            ],
            numericColumns: const {2, 4},
            rows: [
              for (final w in list)
                DataRow(cells: [
                  DataCell(
                      Text(formatDateTime(w.created), style: AppText.body)),
                  DataCell(Text(w.productTitle, style: AppText.bodyStrong)),
                  DataCell(Text("${_qty(w.quantity)} ${w.productUnit}",
                      style: AppText.body)),
                  DataCell(AppBadge(tr("reason_${w.reason}"),
                      tone: AppTone.warning)),
                  DataCell(
                      Text(_money(w.totalCost), style: AppText.bodyStrong)),
                  DataCell(
                      Text(w.note.isEmpty ? "—" : w.note, style: AppText.body)),
                  DataCell(Text(w.userName, style: AppText.body)),
                ]),
            ],
          );
        },
      ),
    );
  }
}

class _InventoryTable extends StatelessWidget {
  final VoidCallback onRetry;

  const _InventoryTable({required this.onRetry});

  AppTone _tone(String status) => switch (status) {
        "completed" => AppTone.success,
        "cancelled" => AppTone.neutral,
        _ => AppTone.info,
      };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInventoryCountsBloc, GetInventoryCountsState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        inPrepare: () => const AppLoading(),
        failure: (e) => AppErrorState(message: e.message, onRetry: onRetry),
        success: (model) {
          final list = model.data.models;
          if (list.isEmpty) {
            return _empty(Icons.fact_check_rounded, "no_inventories");
          }
          return AppDataTable(
            columns: [
              "#",
              tr("date"),
              tr("status"),
              tr("products"),
              tr("completed_at"),
              tr("employee"),
            ],
            numericColumns: const {3},
            rows: [
              for (final c in list)
                DataRow(
                  onSelectChanged: (_) =>
                      showInventoryCountPanel(context, c.id),
                  cells: [
                    DataCell(Text("${c.id}", style: AppText.bodyStrong)),
                    DataCell(
                        Text(formatDateTime(c.created), style: AppText.body)),
                    DataCell(AppBadge(tr("inventory_status_${c.status}"),
                        tone: _tone(c.status))),
                    DataCell(Text("${c.itemsCount}", style: AppText.body)),
                    DataCell(Text(
                        c.completedAt.isEmpty
                            ? "—"
                            : formatDateTime(c.completedAt),
                        style: AppText.body)),
                    DataCell(Text(c.userName, style: AppText.body)),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}
