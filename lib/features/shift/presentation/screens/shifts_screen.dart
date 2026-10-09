import 'package:go_router/go_router.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../../../cash/presentation/widgets/transaction_detail_modal.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';

class ShiftsScreen extends StatefulWidget {
  const ShiftsScreen({super.key});

  @override
  State<ShiftsScreen> createState() => _ShiftsScreenState();
}

class _ShiftsScreenState extends State<ShiftsScreen> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    context.read<CurrentShiftBloc>().add(const CurrentShiftStarted());
    context.read<GetShiftsBloc>().add(
        const GetShiftsStarted(cursor: "", pageSize: 50, from: "", to: ""));
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  Future<void> _askAmount({
    required String title,
    required String label,
    required void Function(int amount, String note) onConfirm,
    bool withNote = false,
  }) {
    final amountCtrl = TextEditingController();
    final noteCtrl = TextEditingController();
    return showDialog(
      context: context,
      builder: (dContext) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(title, style: AppText.h2),
                const SizedBox(height: AppSpacing.lg),
                AppTextField(
                  label: label,
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorFormatter(),
                  ],
                ),
                if (withNote) ...[
                  const AppFormGap(),
                  AppTextField(label: tr("note"), controller: noteCtrl),
                ],
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
                      onPressed: () {
                        onConfirm(parseAmountInt(amountCtrl.text),
                            noteCtrl.text.trim());
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

  void _openShift() => _askAmount(
        title: tr("open_shift"),
        label: tr("opening_cash"),
        onConfirm: (amount, _) => context
            .read<OpenShiftBloc>()
            .add(OpenShiftStarted(openingCash: amount)),
      );

  void _closeShift(CashShiftModel shift) => _askAmount(
        title: tr("close_shift"),
        label: tr("counted_cash"),
        withNote: true,
        onConfirm: (amount, note) => context.read<CloseShiftBloc>().add(
            CloseShiftStarted(id: shift.id, closingCash: amount, note: note)),
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OpenShiftBloc, OpenShiftState>(
          listener: (context, state) => state.whenOrNull(
            success: (_) {
              _snack(tr("shift_opened"));
              _load();
            },
            failure: (error) => _snack(error.message),
          ),
        ),
        BlocListener<CloseShiftBloc, CloseShiftState>(
          listener: (context, state) => state.whenOrNull(
            success: (shift) {
              _snack(tr("shift_closed_result", args: [
                formatCurrency(
                    parseAmount(shift.difference).toStringAsFixed(0)),
              ]));
              _load();
            },
            failure: (error) => _snack(error.message),
          ),
        ),
      ],
      child: AppPage(
        toolbar: AppPageHeader(
          leading: AppBackButton(
            tooltip: tr("back_to_cash"),
            onTap: () => context.go("/cash"),
          ),
          icon: Icons.manage_history_rounded,
          title: tr("cash_shifts"),
          actions: [
            AppIconButton(
              icon: Icons.autorenew_rounded,
              tooltip: tr("refresh"),
              onPressed: _load,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<CurrentShiftBloc, CurrentShiftState>(
                builder: (context, state) => state.when(
                  initial: () => const SizedBox.shrink(),
                  inPrepare: () =>
                      const SizedBox(height: 120, child: AppLoading()),
                  failure: (error) =>
                      AppErrorState(message: error.message, onRetry: _load),
                  success: (model) => _CurrentShiftCard(
                    shift: model.shift,
                    onOpen: _openShift,
                    onClose: _closeShift,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppSectionHeader(
                title: tr("shift_history"),
                icon: Icons.history_rounded,
                iconColor: AppColors.info,
              ),
              const SizedBox(height: AppSpacing.md),
              BlocBuilder<GetShiftsBloc, GetShiftsState>(
                builder: (context, state) => state.when(
                  initial: () => const SizedBox.shrink(),
                  inPrepare: () =>
                      const SizedBox(height: 200, child: AppLoading()),
                  failure: (error) =>
                      AppErrorState(message: error.message, onRetry: _load),
                  success: (model) => _ShiftHistoryTable(
                    shifts: model.data.models,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurrentShiftCard extends StatelessWidget {
  final CashShiftModel? shift;
  final VoidCallback onOpen;
  final void Function(CashShiftModel shift) onClose;

  const _CurrentShiftCard({
    required this.shift,
    required this.onOpen,
    required this.onClose,
  });

  String _money(String value) =>
      formatCurrency(parseAmount(value).toStringAsFixed(0));

  @override
  Widget build(BuildContext context) {
    final shift = this.shift;
    if (shift == null) {
      return AppCard(
        child: Row(
          children: [
            const AppSoftIcon(
              icon: Icons.lock_clock_rounded,
              color: AppColors.warning,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(tr("no_open_shift"), style: AppText.h3),
            ),
            AppButton(
              label: tr("open_shift"),
              icon: Icons.lock_open_rounded,
              onPressed: onOpen,
            ),
          ],
        ),
      );
    }

    final tiles = [
      (
        tr("opening_cash"),
        shift.openingCash,
        Icons.account_balance_wallet_rounded,
        AppColors.primary,
      ),
      (
        tr("cash_sales"),
        shift.cashSales,
        Icons.payments_rounded,
        AppColors.success,
      ),
      (
        tr("card_sales"),
        shift.cardSales,
        Icons.credit_card_rounded,
        AppColors.info,
      ),
      (
        tr("debt_collected"),
        shift.debtCollected,
        Icons.call_received_rounded,
        AppColors.chartPurchase,
      ),
      (
        tr("cash_refunds"),
        shift.cashRefunds,
        Icons.assignment_return_rounded,
        AppColors.danger,
      ),
      (
        tr("expected_cash"),
        shift.expectedCash,
        Icons.calculate_rounded,
        AppColors.warning,
      ),
    ];

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppSectionHeader(
            title: tr("current_shift"),
            icon: Icons.lock_open_rounded,
            iconColor: AppColors.success,
            subtitle:
                "${shift.cashierName} · ${formatDateTime(shift.openedAt)} · ${tr("transactions")}: ${shift.transactionsCount}",
            trailing: AppButton.danger(
              label: tr("close_shift"),
              icon: Icons.lock_rounded,
              onPressed: () => onClose(shift),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          LayoutBuilder(
            builder: (context, constraints) {
              final cols = context.isMobile ? 2 : 3;
              final width =
                  (constraints.maxWidth - AppSpacing.sm * (cols - 1)) / cols;
              return Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final (label, value, icon, color) in tiles)
                    SizedBox(
                      width: width,
                      child: AppStatTile(
                        label: label,
                        value: _money(value),
                        icon: icon,
                        color: color,
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ShiftHistoryTable extends StatelessWidget {
  final List<CashShiftModel> shifts;

  const _ShiftHistoryTable({required this.shifts});

  String _money(String value) => value.isEmpty
      ? "—"
      : formatCurrency(parseAmount(value).toStringAsFixed(0),
          withCurrency: false);

  Widget _difference(CashShiftModel shift) {
    if (shift.difference.isEmpty) {
      return AppBadge(tr("open"), tone: AppTone.info);
    }
    final value = parseAmount(shift.difference);
    final tone = value == 0
        ? AppTone.success
        : value < 0
            ? AppTone.danger
            : AppTone.warning;
    return AppBadge(_money(shift.difference), tone: tone);
  }

  @override
  Widget build(BuildContext context) {
    if (shifts.isEmpty) {
      return AppCard(
        child: EmptyState(
          icon: Icons.history_rounded,
          message: tr("no_shifts"),
        ),
      );
    }
    return AppDataTable(
      columns: [
        tr("cashier"),
        tr("opened_at"),
        tr("closed_at"),
        tr("opening_cash"),
        tr("cash_sales"),
        tr("card_sales"),
        tr("expected_cash"),
        tr("counted_cash"),
        tr("difference"),
      ],
      numericColumns: const {3, 4, 5, 6, 7},
      rows: [
        for (final s in shifts)
          DataRow(cells: [
            DataCell(Text(s.cashierName, style: AppText.bodyStrong)),
            DataCell(Text(formatDateTime(s.openedAt), style: AppText.body)),
            DataCell(Text(s.closedAt.isEmpty ? "—" : formatDateTime(s.closedAt),
                style: AppText.body)),
            DataCell(Text(_money(s.openingCash), style: AppText.body)),
            DataCell(Text(_money(s.cashSales), style: AppText.body)),
            DataCell(Text(_money(s.cardSales), style: AppText.body)),
            DataCell(Text(_money(s.expectedCash), style: AppText.bodyStrong)),
            DataCell(Text(_money(s.closingCash), style: AppText.body)),
            DataCell(_difference(s)),
          ]),
      ],
    );
  }
}
