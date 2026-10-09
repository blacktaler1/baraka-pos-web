import 'package:baraka_pos/shared/aplication/configs/di/injection_container.dart';
import 'package:flutter/services.dart';
import '../../domain/payload/update_loan_payload.dart';
import '../../domain/repository/firma_repository.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../blocs/blocs.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/pagination_widget.dart';
import '../blocs/loan_debt_bloc/loan_debt_bloc.dart';
import '../widgets/add_loan_form.dart';
import '../widgets/pay_debt_form.dart';

class DebtTab extends StatelessWidget {
  final int firmaId;

  const DebtTab({super.key, required this.firmaId});

  @override
  Widget build(BuildContext context) =>
      LoanTab(key: const ValueKey('debts'), firmaId: firmaId, isDebt: true);
}

class PaymentTab extends StatelessWidget {
  final int firmaId;

  const PaymentTab({super.key, required this.firmaId});

  @override
  Widget build(BuildContext context) => LoanTab(
        key: const ValueKey('payments'),
        firmaId: firmaId,
        isDebt: false,
      );
}

class LoanTab extends StatefulWidget {
  final int firmaId;
  final bool isDebt;

  const LoanTab({super.key, required this.firmaId, required this.isDebt});

  @override
  State<LoanTab> createState() => _LoanTabState();
}

class _LoanTabState extends State<LoanTab> {
  final TextEditingController searchController = TextEditingController();
  int currentPage = 1;
  int rowsPerPage = 10;
  int totalItems = 0;
  List<String?> cursors = [null];

  void _edit(dynamic item) {
    showDialog(
      context: context,
      builder: (_) => _EditLoanDialog(
        firmaId: widget.firmaId,
        loanId: item.id as int,
        title: item.title as String,
        debt: item.debt as String,
        onSaved: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(tr("debt_updated"))));
          _load(cursor: "");
          context
              .read<GetByIdFirmaBloc>()
              .add(GetByIdFirmaStarted(id: widget.firmaId));
        },
      ),
    );
  }

  void _load({required String cursor}) {
    context.read<LoanDebtBloc>().add(LoanDebtStarted(
          search: searchController.text,
          cursor: cursor,
          pageSize: rowsPerPage,
          debt: widget.isDebt,
          firmaId: widget.firmaId,
        ));
  }

  void _reset() {
    currentPage = 1;
    cursors = [null];
    totalItems = 0;
  }

  void onPageChanged(int page) {
    if (page == currentPage) return;
    setState(() => currentPage = page);
    _load(cursor: cursors[page - 1] ?? "");
  }

  void onRowsPerPageChanged(int value) {
    setState(() {
      rowsPerPage = value;
      _reset();
    });
    _load(cursor: "");
  }

  void onSearchChange(String value) {
    setState(_reset);
    _load(cursor: "");
  }

  @override
  void initState() {
    super.initState();
    _load(cursor: "");
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  String _date(String? created) {
    final createdAt = DateTime.tryParse(created ?? '');
    if (createdAt == null) return '';
    return DateFormat('dd.MM.yyyy').format(createdAt.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppToolbar(
          leading: [
            AppSearchField(
              controller: searchController,
              onChanged: onSearchChange,
            ),
          ],
          trailing: [
            AppButton(
              label: widget.isDebt ? tr("add_debt") : tr("add_payment"),
              icon: widget.isDebt
                  ? Icons.post_add_rounded
                  : Icons.add_card_rounded,
              onPressed: () => showLoanPanel(
                context,
                firmaId: widget.firmaId,
                isDebt: widget.isDebt,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: BlocConsumer<LoanDebtBloc, LoanDebtState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (model) {
                  setState(() {
                    totalItems = model.total;
                    if (model.next.isNotEmpty &&
                        currentPage == cursors.length) {
                      cursors.add(model.next);
                    }
                  });
                },
                failure: (error) => ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(error.message))),
              );
            },
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox.shrink(),
                inPrepare: () => const AppLoading(),
                failure: (error) => AppErrorState(
                  message: error.toString(),
                  onRetry: () => _load(cursor: ""),
                ),
                success: (model) {
                  final items = model.data.models;
                  if (items.isEmpty) {
                    return AppCard(
                      child: EmptyState(
                        icon: widget.isDebt
                            ? Icons.money_off_rounded
                            : Icons.credit_card_off_rounded,
                        message: tr("not_found"),
                      ),
                    );
                  }
                  return AppDataTable(
                    columns: [
                      tr("description"),
                      tr("date"),
                      widget.isDebt
                          ? tr("debt_amount")
                          : tr("payment_amount_short"),
                      if (widget.isDebt) "",
                    ],
                    numericColumns: const {2},
                    rows: items.map((item) {
                      final amount = widget.isDebt ? item.debt : item.paid;
                      final color =
                          widget.isDebt ? AppColors.danger : AppColors.success;
                      return DataRow(cells: [
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppSoftIcon(
                                icon: widget.isDebt
                                    ? Icons.receipt_long_rounded
                                    : Icons.payments_rounded,
                                color: color,
                                size: 34,
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 380),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title.isEmpty ? '-' : item.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppText.bodyMedium,
                                    ),
                                    Text(
                                      '#${item.id}',
                                      style: AppText.caption.copyWith(
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
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
                              Text(_date(item.created), style: AppText.small),
                            ],
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.isDebt
                                    ? Icons.south_west_rounded
                                    : Icons.north_east_rounded,
                                size: 14,
                                color: color,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                formatCurrency(amount),
                                style:
                                    AppText.bodyStrong.copyWith(color: color),
                              ),
                            ],
                          ),
                        ),
                        if (widget.isDebt)
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppIconButton(
                                  icon: Icons.edit_rounded,
                                  tooltip: tr("edit_debt"),
                                  color: AppColors.info,
                                  onPressed: () => _edit(item),
                                ),
                                const SizedBox(width: AppSpacing.xxs),
                                AppButton.secondary(
                                  label: tr("pay_debt"),
                                  icon: Icons.price_check_rounded,
                                  size: AppButtonSize.sm,
                                  onPressed: () => showPayDebtPanel(
                                    context,
                                    title: item.title,
                                    debtPrice: item.debt,
                                    firmaId: widget.firmaId,
                                    debtId: item.id,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ]);
                    }).toList(),
                  );
                },
              );
            },
          ),
        ),
        if (totalItems > 0) ...[
          const SizedBox(height: AppSpacing.md),
          PaginationWidget(
            totalItems: totalItems,
            currentPage: currentPage,
            totalPages: (totalItems / rowsPerPage).ceil(),
            rowsPerPage: rowsPerPage,
            onPageChanged: onPageChanged,
            onRowsPerPageChanged: onRowsPerPageChanged,
          ),
        ],
      ],
    );
  }
}

/// Firma qarzini tahrirlash oynasi
class _EditLoanDialog extends StatefulWidget {
  final int firmaId;
  final int loanId;
  final String title;
  final String debt;
  final VoidCallback onSaved;

  const _EditLoanDialog({
    required this.firmaId,
    required this.loanId,
    required this.title,
    required this.debt,
    required this.onSaved,
  });

  @override
  State<_EditLoanDialog> createState() => _EditLoanDialogState();
}

class _EditLoanDialogState extends State<_EditLoanDialog> {
  late final num _originalDebt = num.tryParse(widget.debt) ?? 0;
  late final _titleCtrl = TextEditingController(text: widget.title);
  late final _debtCtrl = TextEditingController(
    text: formatCurrency(_originalDebt.toStringAsFixed(0), withCurrency: false),
  );
  bool _saving = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _debtCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final title = _titleCtrl.text.trim();
    final debt = parseAmount(_debtCtrl.text);
    final payload = UpdateLoanPayload(
      firmaId: widget.firmaId,
      loanId: widget.loanId,
      title: title != widget.title ? title : null,
      debt: debt != _originalDebt ? debt : null,
    );
    if (payload.isEmpty) {
      Navigator.pop(context);
      return;
    }
    setState(() => _saving = true);
    final result = await sl<FirmaRepository>().updateLoan(payload: payload);
    if (!mounted) return;
    result.when(
      success: (_) {
        Navigator.pop(context);
        widget.onSaved();
      },
      failure: (error) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const AppSoftIcon(
                      icon: Icons.edit_note_rounded, color: AppColors.info),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("edit_debt"), style: AppText.h2),
                        Text("#${widget.loanId}", style: AppText.small),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                label: tr("description"),
                controller: _titleCtrl,
              ),
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: tr("debt_amount"),
                controller: _debtCtrl,
                prefix:
                    const Icon(Icons.account_balance_wallet_rounded, size: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter(),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton.secondary(
                    label: tr("cancel"),
                    onPressed: _saving ? null : () => Navigator.pop(context),
                  ),
                  AppButton(
                    label: tr("save"),
                    icon: Icons.check_circle_rounded,
                    loading: _saving,
                    onPressed: _save,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
