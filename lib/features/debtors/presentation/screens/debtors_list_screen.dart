import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/shared.dart';
import '../../debtors.dart';

class DebtorsListScreen extends StatefulWidget {
  const DebtorsListScreen({super.key});

  @override
  State<DebtorsListScreen> createState() => _DebtorsListScreenState();
}

class _DebtorsListScreenState extends State<DebtorsListScreen> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<GetDebtorsListBloc>().add(
          const GetDebtorsListEvent(
            hasDebt: null,
            nearingDeadline: null,
            search: null,
            ordering: null,
            pageSize: "all",
          ),
        );
  }

  DateTime? _deadline(String dateStr) => DateTime.tryParse(dateStr)?.toLocal();

  // Sanani formatlash funksiyasi: 2026-01-30 -> 30-Yan, 2026
  String _formatDeadline(String dateStr) {
    final date = _deadline(dateStr);
    if (date == null) return dateStr.split('T').first;
    return DateFormat('dd-MMM, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      toolbar: BlocBuilder<GetDebtorsListBloc, GetDebtorsListState>(
        builder: (context, state) {
          final list = state is GetDebtorsListSuccess
              ? state.model.data.models.toList()
              : const [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _header(context, list.length),
              const SizedBox(height: AppSpacing.lg),
              _summary(list, loaded: state is GetDebtorsListSuccess),
            ],
          );
        },
      ),
      child: BlocBuilder<GetDebtorsListBloc, GetDebtorsListState>(
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            inPrepare: () => const AppLoading(),
            failure: (error) =>
                AppErrorState(message: error.toString(), onRetry: _loadData),
            success: (model) {
              final list = model.data.models;
              if (list.isEmpty) {
                return AppCard(
                  child: EmptyState(
                    icon: Icons.sentiment_satisfied_alt_rounded,
                    message: tr("not_debtors"),
                  ),
                );
              }
              return AppDataTable(
                columns: [
                  tr("customer"),
                  tr("total_debt"),
                  tr("invoices"),
                  tr("due_date"),
                  "",
                ],
                numericColumns: const {1},
                rows: list.map<DataRow>(_row).toList(),
              );
            },
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, int count) {
    return AppPageHeader(
      icon: Icons.groups_rounded,
      title: tr("debtor_customers"),
      subtitle: tr("debtors_count", args: ["$count"]),
      actions: [
        BlocConsumer<ExportDebtorsBloc, ExportDebtorsState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (file) async {
                final path = await saveExcelFile(file.bytes, "debtors.xlsx");
                if (path != null && context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(tr("file_saved"))));
                }
              },
              failure: (error) => ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(error.message))),
            );
          },
          builder: (context, state) => AppButton.secondary(
            label: tr("export_excel"),
            icon: Icons.sim_card_download_rounded,
            loading: state is ExportDebtorsPrepare,
            onPressed: () => context
                .read<ExportDebtorsBloc>()
                .add(const ExportDebtorsStarted()),
          ),
        ),
        AppIconButton(
          icon: Icons.autorenew_rounded,
          tooltip: tr("refresh"),
          onPressed: _loadData,
        ),
      ],
    );
  }

  /// Ro'yxatdan hisoblangan umumiy ko'rsatkichlar
  Widget _summary(List list, {required bool loaded}) {
    final now = DateTime.now();
    final totalDebt =
        list.fold<num>(0, (s, e) => s + parseAmount(e.totalDebt.toString()));
    final invoices =
        list.fold<int>(0, (s, e) => s + (e.unPaidRecordsCount as int));
    final overdue = list.where((e) {
      final d = _deadline(e.oldestUnPaidDeadline.toString());
      return d != null && d.isBefore(now);
    }).length;

    String? v(String s) => loaded ? s : null;

    return AppAdaptiveRow(
      children: [
        _SummaryTile(
          icon: Icons.account_balance_wallet_rounded,
          color: AppColors.danger,
          label: tr("total_debt"),
          value: v(formatCurrency(totalDebt.toStringAsFixed(0))),
        ),
        _SummaryTile(
          icon: Icons.groups_rounded,
          color: AppColors.primary,
          label: tr("debtor_customers"),
          value: v("${list.length}"),
        ),
        _SummaryTile(
          icon: Icons.receipt_long_rounded,
          color: AppColors.info,
          label: tr("invoices"),
          value: v("$invoices"),
        ),
        _SummaryTile(
          icon: Icons.alarm_rounded,
          color: AppColors.warning,
          label: tr("overdue_debtors"),
          value: v("$overdue"),
        ),
      ],
    );
  }

  DataRow _row(dynamic item) {
    void openDetails() => showDebtDetailsPanel(
          context,
          customerId: item.id,
          customerName: item.name,
        );

    final deadline = _deadline(item.oldestUnPaidDeadline.toString());
    final now = DateTime.now();
    final overdue = deadline != null && deadline.isBefore(now);
    final soon =
        !overdue && deadline != null && deadline.difference(now).inDays < 3;

    return DataRow(
      onSelectChanged: (_) => openDetails(),
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppAvatar(name: item.name, size: 38),
              const SizedBox(width: AppSpacing.sm),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppText.bodyStrong),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.call_rounded,
                        size: 12,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item.phone.isEmpty ? "-" : item.phone,
                        style: AppText.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.south_west_rounded,
                size: 14,
                color: AppColors.danger,
              ),
              const SizedBox(width: 4),
              Text(
                formatCurrency(item.totalDebt),
                style: AppText.bodyStrong.copyWith(color: AppColors.danger),
              ),
            ],
          ),
        ),
        DataCell(
          AppBadge(
            "${item.unPaidRecordsCount}",
            tone: AppTone.info,
            icon: Icons.receipt_rounded,
          ),
        ),
        DataCell(
          AppBadge(
            _formatDeadline(item.oldestUnPaidDeadline),
            tone: overdue
                ? AppTone.danger
                : (soon ? AppTone.warning : AppTone.neutral),
            icon: overdue
                ? Icons.alarm_on_rounded
                : Icons.event_available_rounded,
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIconButton(
                icon: Icons.history_rounded,
                tooltip: tr("view_history"),
                onPressed: () => showDebtorHistoryPanel(
                  context,
                  customerId: item.id,
                  customerName: item.name,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              AppButton(
                label: tr("pay"),
                icon: Icons.payments_rounded,
                size: AppButtonSize.sm,
                onPressed: openDetails,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  /// null — hali yuklanmoqda
  final String? value;

  const _SummaryTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    return AppSoftCard(
      padding: EdgeInsets.all(mobile ? AppSpacing.sm : AppSpacing.md),
      child: Row(
        children: [
          AppSoftIcon(icon: icon, color: color, size: mobile ? 38 : 44),
          SizedBox(width: mobile ? AppSpacing.xs : AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.small,
                ),
                const SizedBox(height: 2),
                value == null
                    ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(value!, style: AppText.h2),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
