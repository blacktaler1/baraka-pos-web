import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../../domain/model/expense_model.dart';
import '../../domain/model/get_expenses_model.dart';
import '../blocs/get_expenses_bloc/get_expenses_bloc.dart';
import '../widgets/create_expense_sheet.dart';
import '../blocs/delete_expense_bloc/delete_expense_bloc.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];

  @override
  void initState() {
    super.initState();
    loadExpensesData(cursor: "");
  }

  void loadExpensesData({required String cursor}) {
    context.read<GetExpensesBloc>().add(
          GetExpensesStarted(
            cursor: cursor,
            pageSize: rowsPerPage.toString(),
          ),
        );
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;
    setState(() => currentPage = page);
    final String cursorToUse = cursors[page - 1] ?? "";
    loadExpensesData(cursor: cursorToUse);
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      currentPage = 1;
      cursors = [null];
      totalItems = 0;
    });
    loadExpensesData(cursor: "");
  }

  void _reload() => loadExpensesData(cursor: cursors[currentPage - 1] ?? "");

  Future<void> _openPanel({ExpenseModel? expense}) async {
    final result = await showExpensePanel(context, expense: expense);
    if (result == true) _reload();
  }

  Future<void> _confirmDelete(ExpenseModel expense) async {
    final confirmed = await showAppConfirm(
      context,
      title: tr("confirm_delete"),
      message: "${expense.title}. ${tr("delete_warning")}",
      confirmLabel: tr("yes_delete"),
      danger: true,
    );
    if (confirmed && mounted) {
      context
          .read<DeleteExpenseBloc>()
          .add(DeleteExpenseStarted(id: expense.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteExpenseBloc, DeleteExpenseState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (_) => _reload(),
          failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message)),
          ),
        );
      },
      child: AppPage(
        toolbar: AppPageHeader(
          icon: Icons.receipt_long_rounded,
          title: tr("expenses"),
          subtitle: tr("expenses_count", args: ["$totalItems"]),
          actions: [
            AppButton(
              label: tr("add_new"),
              icon: Icons.add_card_rounded,
              onPressed: () => _openPanel(),
            ),
          ],
        ),
        footer: totalItems > 0
            ? PaginationWidget(
                totalItems: totalItems,
                currentPage: currentPage,
                totalPages: (totalItems / rowsPerPage).ceil(),
                rowsPerPage: rowsPerPage,
                onPageChanged: onPageChanged,
                onRowsPerPageChanged: onRowsPerPageChanged,
              )
            : null,
        child: BlocConsumer<GetExpensesBloc, GetExpensesState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                setState(() {
                  totalItems = model.total;
                  if (model.next.isNotEmpty && currentPage == cursors.length) {
                    cursors.add(model.next);
                  }
                });
              },
              failure: (error) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(error.message)),
              ),
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              inPrepare: () => const AppLoading(),
              failure: (error) =>
                  AppErrorState(message: error.toString(), onRetry: _reload),
              success: _buildContent,
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(GetExpensesModel model) {
    final average = model.total > 0 ? model.totalAmount / model.total : 0;
    final mobile = context.isMobile;
    final records = _MiniStat(
      icon: Icons.format_list_numbered_rounded,
      color: AppColors.info,
      label: tr("expenses_records"),
      value: "${model.total}",
    );
    final avg = _MiniStat(
      icon: Icons.functions_rounded,
      color: AppColors.warning,
      label: tr("average_expense"),
      value: formatCurrency(average.toStringAsFixed(0)),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (mobile) ...[
          _TotalCard(amount: model.totalAmount),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(child: records),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: avg),
            ],
          ),
        ] else
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: _TotalCard(amount: model.totalAmount),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _MiniStat(
                    icon: Icons.format_list_numbered_rounded,
                    color: AppColors.info,
                    label: tr("expenses_records"),
                    value: "${model.total}",
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _MiniStat(
                    icon: Icons.functions_rounded,
                    color: AppColors.warning,
                    label: tr("average_expense"),
                    value: formatCurrency(average.toStringAsFixed(0)),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: mobile ? AppSpacing.sm : AppSpacing.lg),
        Expanded(
          child: model.data.models.isEmpty
              ? AppCard(
                  child: EmptyState(
                    icon: Icons.money_off_rounded,
                    message: tr("no_expenses"),
                  ),
                )
              : AppDataTable(
                  columns: [
                    tr("title"),
                    tr("date"),
                    tr("amount"),
                    "",
                  ],
                  numericColumns: const {2},
                  rows: model.data.models.map(_row).toList(),
                ),
        ),
      ],
    );
  }

  DataRow _row(ExpenseModel expense) {
    final (icon, color) = expenseIconFor(expense.title);
    final created = DateTime.tryParse(expense.created)?.toLocal();
    return DataRow(
      cells: [
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSoftIcon(icon: icon, color: color, size: 36),
              const SizedBox(width: AppSpacing.sm),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Text(
                  expense.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.event_rounded,
                size: 14,
                color: AppColors.textTertiary,
              ),
              const SizedBox(width: 6),
              Text(
                created == null
                    ? expense.created
                    : DateFormat('dd.MM.yyyy  HH:mm').format(created),
                style: AppText.small,
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.south_east_rounded,
                size: 14,
                color: AppColors.danger,
              ),
              const SizedBox(width: 4),
              Text(
                formatCurrency(expense.amount.toString()),
                style: AppText.bodyStrong.copyWith(color: AppColors.danger),
              ),
            ],
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIconButton(
                icon: Icons.edit_rounded,
                tooltip: tr("edit"),
                color: AppColors.info,
                onPressed: () => _openPanel(expense: expense),
              ),
              AppIconButton(
                icon: Icons.delete_rounded,
                tooltip: tr("delete"),
                color: AppColors.danger,
                onPressed: () => _confirmDelete(expense),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Xarajat nomidagi kalit so'zlarga qarab ikona va rang tanlash
(IconData, Color) expenseIconFor(String title) {
  final t = title.toLowerCase();
  bool has(List<String> words) => words.any(t.contains);

  if (has(["ijara", "аренд", "rent"])) {
    return (Icons.home_work_rounded, AppColors.info);
  }
  if (has(["svet", "elektr", "свет", "электр"])) {
    return (Icons.bolt_rounded, AppColors.gold);
  }
  if (has(["gaz", "газ"])) {
    return (Icons.local_fire_department_rounded, AppColors.warning);
  }
  if (has(["suv", "вод"])) {
    return (Icons.water_drop_rounded, AppColors.info);
  }
  if (has([
    "benzin",
    "yoqilg",
    "transport",
    "taksi",
    "yo'l",
    "бензин",
    "транспорт",
    "такси",
    "доставк",
    "dostavka"
  ])) {
    return (Icons.local_shipping_rounded, AppColors.chartPurchase);
  }
  if (has(["oylik", "maosh", "ish haqi", "зарплат", "оклад"])) {
    return (Icons.badge_rounded, AppColors.success);
  }
  if (has(["internet", "aloqa", "telefon", "интернет", "связь"])) {
    return (Icons.wifi_rounded, AppColors.primary);
  }
  if (has(["soliq", "налог", "jarima", "штраф"])) {
    return (Icons.account_balance_rounded, AppColors.danger);
  }
  if (has(["ovqat", "tushlik", "еда", "обед", "kofe", "choy"])) {
    return (Icons.restaurant_rounded, AppColors.warning);
  }
  if (has(["ta'mir", "remont", "ремонт", "usta"])) {
    return (Icons.build_rounded, AppColors.textSecondary);
  }
  if (has(["reklama", "реклам", "marketing"])) {
    return (Icons.campaign_rounded, AppColors.chartPurchase);
  }
  return (Icons.receipt_rounded, AppColors.danger);
}

class _TotalCard extends StatelessWidget {
  final num amount;

  const _TotalCard({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFC6483D), Color(0xFF8E2A22)],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.danger.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "general_costs".tr(),
                        style: AppText.small.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          formatCurrency(amount.toString()),
                          style: AppText.display.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final String value;

  const _MiniStat({
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.small,
                ),
                const SizedBox(height: 2),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(value, style: AppText.h2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
