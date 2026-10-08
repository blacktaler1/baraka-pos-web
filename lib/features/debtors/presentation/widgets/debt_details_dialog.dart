import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/shared.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../debtors.dart';

Future<void> showDebtDetailsPanel(
  BuildContext context, {
  required int customerId,
  required String customerName,
}) {
  context.read<ByCustomerBloc>().add(ByCustomerEvent(id: customerId));
  return showAppSidePanel(
    context,
    width: AppSizes.sidePanelWidthWide,
    builder: (_) =>
        DebtDetailsDialog(customerId: customerId, customerName: customerName),
  );
}

Future<void> showDebtorHistoryPanel(
  BuildContext context, {
  required int customerId,
  required String customerName,
}) {
  context
      .read<ByCustomerHistoryBloc>()
      .add(ByCustomerHistoryStarted(id: customerId, history: true));
  return showAppSidePanel(
    context,
    builder: (_) => _HistoryPanel(customerName: customerName),
  );
}

class DebtDetailsDialog extends StatelessWidget {
  final int customerId;
  final String customerName;

  const DebtDetailsDialog({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  void _snack(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));

  void _refresh(BuildContext context) {
    context.read<ByCustomerBloc>().add(ByCustomerEvent(id: customerId));
    context.read<GetDebtorsListBloc>().add(const GetDebtorsListEvent(
          hasDebt: null,
          nearingDeadline: null,
          ordering: null,
          pageSize: "all",
          search: null,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayDebtBloc, PayDebtState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                _snack(context, model.message);
                _refresh(context);
              },
              failure: (error) => _snack(context, error.toString()),
            );
          },
        ),
        BlocListener<PayCustomerDebtsBloc, PayCustomerDebtsState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (model) {
                _snack(
                  context,
                  tr("debts_paid_result", args: [
                    formatCurrency(model.paidAmount.toString()),
                    "${model.recordsAffected}",
                  ]),
                );
                _refresh(context);
              },
              failure: (error) => _snack(context, error.message),
            );
          },
        ),
      ],
      child: AppSidePanel(
        title: customerName,
        subtitle: tr("debt_list"),
        icon: Icons.person_rounded,
        iconColor: AppColors.danger,
        actions: [
          BlocBuilder<ByCustomerBloc, ByCustomerState>(
            builder: (context, state) {
              final total = state is ByCustomerSuccess
                  ? state.model.debtCollection.models
                      .where((d) => !d.isPaid)
                      .fold<num>(0, (sum, d) => sum + parseAmount(d.debt))
                  : 0;
              return AppButton(
                label: tr("pay_all_debts"),
                icon: Icons.price_check_rounded,
                onPressed:
                    total > 0 ? () => _showPayAllDialog(context, total) : null,
              );
            },
          ),
        ],
        body: BlocBuilder<ByCustomerBloc, ByCustomerState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              inPrepare: () => const SizedBox(height: 200, child: AppLoading()),
              failure: (error) => AppErrorState(message: error.toString()),
              success: (model) {
                final debts = model.debtCollection.models;
                if (debts.isEmpty) {
                  return EmptyState(
                    icon: Icons.verified_rounded,
                    message: tr("no_debts"),
                  );
                }
                final unpaid = debts.where((d) => !d.isPaid).toList();
                final remaining =
                    unpaid.fold<num>(0, (sum, d) => sum + parseAmount(d.debt));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _DebtSummary(
                      remaining: remaining,
                      unpaidCount: unpaid.length,
                      totalCount: debts.length,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    for (var i = 0; i < debts.length; i++) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.sm),
                      _DebtInvoiceCard(debt: debts[i]),
                    ],
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showPayAllDialog(BuildContext context, num total) {
    final controller = TextEditingController(
      text: formatCurrency(total.toStringAsFixed(0), withCurrency: false),
    );
    final bloc = context.read<PayCustomerDebtsBloc>();

    showDialog(
      context: context,
      builder: (dContext) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AppSoftIcon(
                      icon: Icons.price_check_rounded,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("pay_all_debts"), style: AppText.h2),
                          Text(
                            "${tr("total_debt")}: ${formatCurrency(total.toStringAsFixed(0))}",
                            style: AppText.small,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.info_rounded,
                        size: 14, color: AppColors.info),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(tr("pay_all_debts_hint"),
                          style: AppText.caption),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: tr("amount"),
                  controller: controller,
                  prefix: const Icon(Icons.payments_rounded, size: 18),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorFormatter(),
                  ],
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton.secondary(
                      label: tr("cancel"),
                      onPressed: () => Navigator.pop(dContext),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AppButton(
                      label: tr("confirm"),
                      icon: Icons.check_circle_rounded,
                      onPressed: () {
                        final amount = parseAmount(controller.text);
                        if (amount <= 0) return;
                        bloc.add(PayCustomerDebtsStarted(
                          customerId: customerId,
                          amount: amount >= total
                              ? "all"
                              : amount.toStringAsFixed(0),
                        ));
                        Navigator.pop(dContext);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DebtInvoiceCard extends StatelessWidget {
  final ByCustomerItemModel debt;

  const _DebtInvoiceCard({required this.debt});

  @override
  Widget build(BuildContext context) {
    final color = debt.isPaid ? AppColors.success : AppColors.danger;
    final deadline = DateTime.tryParse(debt.deadline)?.toLocal();
    final overdue =
        !debt.isPaid && deadline != null && deadline.isBefore(DateTime.now());

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xxs,
          ),
          childrenPadding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            0,
            AppSpacing.md,
            AppSpacing.md,
          ),
          leading: AppSoftIcon(
            icon: debt.isPaid
                ? Icons.task_alt_rounded
                : Icons.receipt_long_rounded,
            color: color,
            size: 40,
          ),
          title:
              Text("${tr("invoice")} #${debt.id}", style: AppText.bodyStrong),
          subtitle: Row(
            children: [
              Flexible(
                child: Text(
                  "${tr("remaining_debt")}: ${formatCurrency(debt.debt)}",
                  overflow: TextOverflow.ellipsis,
                  style: AppText.small.copyWith(color: color),
                ),
              ),
              if (deadline != null) ...[
                const SizedBox(width: AppSpacing.xs),
                Icon(
                  overdue ? Icons.alarm_on_rounded : Icons.event_rounded,
                  size: 12,
                  color: overdue ? AppColors.danger : AppColors.textTertiary,
                ),
                const SizedBox(width: 3),
                Text(
                  DateFormat('dd.MM.yyyy').format(deadline),
                  style: AppText.caption.copyWith(
                    color: overdue ? AppColors.danger : AppColors.textTertiary,
                  ),
                ),
              ],
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              debt.isPaid
                  ? AppBadge(tr("paid"),
                      tone: AppTone.success, icon: Icons.verified_rounded)
                  : AppButton(
                      label: tr("pay"),
                      icon: Icons.payments_rounded,
                      size: AppButtonSize.sm,
                      onPressed: () => _showPayDialog(context, debt),
                    ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textSecondary),
            ],
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Column(
                children: [
                  for (final item in debt.items.models)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_basket_rounded,
                            size: 15,
                            color: AppColors.textTertiary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Expanded(
                            child: Text(
                              "${item.productTitle} × ${item.quantity}",
                              style: AppText.body,
                            ),
                          ),
                          Text(
                            formatCurrency(item.subTotal.toString()),
                            style: AppText.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPayDialog(BuildContext context, ByCustomerItemModel debt) {
    final controller = TextEditingController(text: debt.debt.toString());
    final payBloc = context.read<PayDebtBloc>();

    showDialog(
      context: context,
      builder: (dContext) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const AppSoftIcon(
                      icon: Icons.payments_rounded,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("pay_debt"), style: AppText.h2),
                        Text(
                          "${tr("invoice")} #${debt.id}",
                          style: AppText.small,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: tr("amount"),
                  controller: controller,
                  prefix: const Icon(Icons.payments_rounded, size: 18),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  ],
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.sm),
                    child: Center(
                      widthFactor: 1,
                      child: Text(tr("currency"), style: AppText.small),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButton.secondary(
                      label: tr("cancel"),
                      onPressed: () => Navigator.pop(dContext),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    BlocBuilder<PayDebtBloc, PayDebtState>(
                      bloc: payBloc,
                      builder: (context, state) => AppButton(
                        label: tr("confirm"),
                        icon: Icons.check_circle_rounded,
                        loading: state is PayDebtPrepare,
                        onPressed: () {
                          final amount = num.tryParse(controller.text) ?? 0;
                          if (amount > 0) {
                            payBloc
                                .add(PayDebtEvent(id: debt.id, amount: amount));
                            Navigator.pop(dContext);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryPanel extends StatelessWidget {
  final String customerName;

  const _HistoryPanel({required this.customerName});

  @override
  Widget build(BuildContext context) {
    return AppSidePanel(
      title: tr("payment_history"),
      subtitle: customerName,
      icon: Icons.history_rounded,
      iconColor: AppColors.info,
      body: BlocBuilder<ByCustomerHistoryBloc, ByCustomerHistoryState>(
        builder: (context, state) {
          if (state is ByCustomerHistoryPrepare) {
            return const SizedBox(height: 200, child: AppLoading());
          }
          if (state is ByCustomerHistoryFailure) {
            return AppErrorState(message: state.error.toString());
          }
          if (state is! ByCustomerHistorySuccess) {
            return const SizedBox.shrink();
          }

          final list = state.model.data.models;
          if (list.isEmpty) {
            return EmptyState(
              icon: Icons.manage_search_rounded,
              message: tr("no_history"),
            );
          }
          return Column(
            children: [
              for (var i = 0; i < list.length; i++) ...[
                if (i > 0) const Divider(),
                _historyRow(list[i]),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _historyRow(ByCustomerHistoryModel history) {
    final isDebt = history.historyType.toLowerCase().contains("debt") ||
        num.tryParse(history.paid) == 0;
    final color = isDebt ? AppColors.danger : AppColors.success;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          AppSoftIcon(
            icon: isDebt ? Icons.shopping_bag_rounded : Icons.payments_rounded,
            color: color,
            size: 40,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${tr("invoice")} #${history.id}",
                    style: AppText.bodyStrong),
                Row(
                  children: [
                    const Icon(Icons.event_rounded,
                        size: 12, color: AppColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(history.historyDate.split('T').first,
                        style: AppText.caption),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isDebt
                        ? Icons.south_west_rounded
                        : Icons.north_east_rounded,
                    size: 13,
                    color: color,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    formatCurrency(history.paid),
                    style: AppText.bodyStrong.copyWith(color: color),
                  ),
                ],
              ),
              if (history.historyUser.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.badge_rounded,
                        size: 12, color: AppColors.textTertiary),
                    const SizedBox(width: 4),
                    Text(history.historyUser, style: AppText.caption),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Tafsilotlar panelining yuqorisidagi umumiy qarz kartasi
class _DebtSummary extends StatelessWidget {
  final num remaining;
  final int unpaidCount;
  final int totalCount;

  const _DebtSummary({
    required this.remaining,
    required this.unpaidCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final paidShare =
        totalCount > 0 ? (totalCount - unpaidCount) / totalCount : 1.0;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tr("remaining_debt"),
                  style: AppText.small.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    formatCurrency(remaining.toStringAsFixed(0)),
                    style: AppText.display.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: paidShare.toDouble(),
                          minHeight: 5,
                          backgroundColor: Colors.white.withValues(alpha: 0.2),
                          valueColor:
                              const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    const Icon(Icons.receipt_long_rounded,
                        size: 13, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      "$unpaidCount / $totalCount",
                      style: AppText.caption.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
