import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../blocs/loan_debt_bloc/loan_debt_bloc.dart';
import '../blocs/pay_debt_bloc/pay_debt_bloc.dart';

Future<void> showPayDebtPanel(
  BuildContext context, {
  required String title,
  required String debtPrice,
  required int firmaId,
  required int debtId,
}) {
  return showAppSidePanel(
    context,
    builder: (_) => PayDebtForm(
      title: title,
      debtPrice: debtPrice,
      firmaId: firmaId,
      debtId: debtId,
    ),
  );
}

class PayDebtForm extends StatefulWidget {
  final String title;
  final String debtPrice;
  final int firmaId;
  final int debtId;

  const PayDebtForm({
    super.key,
    required this.title,
    required this.debtPrice,
    required this.firmaId,
    required this.debtId,
  });

  @override
  State<PayDebtForm> createState() => _PayDebtFormState();
}

class _PayDebtFormState extends State<PayDebtForm> {
  final amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _submit() {
    if (amountController.text.trim().isEmpty) return;
    context.read<LoanFirmaBloc>().add(LoanFirmaStarted(
          firmaId: widget.firmaId,
          debtId: widget.debtId,
          amount: parseAmountInt(amountController.text),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoanFirmaBloc, LoanFirmaState>(
      listener: (context, state) {
        state.whenOrNull(success: (_) {
          Navigator.of(context).pop();
          context.read<LoanDebtBloc>().add(LoanDebtStarted(
                search: "",
                cursor: "",
                pageSize: 10,
                debt: true,
                firmaId: widget.firmaId,
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('debt_paid_successfully'.tr())),
          );
        });
      },
      builder: (context, state) {
        final loading =
            state.maybeWhen(inPrepare: () => true, orElse: () => false);
        return AppSidePanel(
          title: tr("pay_debt"),
          subtitle: widget.title,
          icon: Icons.price_check_rounded,
          iconColor: AppColors.success,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.dangerSoft,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.danger.withValues(alpha: 0.15),
                  ),
                ),
                child: Row(
                  children: [
                    const AppSoftIcon(
                      icon: Icons.account_balance_wallet_rounded,
                      color: AppColors.danger,
                      size: 40,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(tr("debt_amount"), style: AppText.small),
                    ),
                    Text(
                      formatCurrency(widget.debtPrice),
                      style: AppText.h2.copyWith(color: AppColors.danger),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              AppTextField(
                label: tr("enter_payment_amount"),
                required: true,
                hint: tr("enter_amount"),
                controller: amountController,
                prefix: const Icon(Icons.payments_rounded, size: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter(),
                ],
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: AppSpacing.xs),
              Align(
                alignment: Alignment.centerLeft,
                child: AppButton.ghost(
                  label: tr("fill_full_amount"),
                  icon: Icons.done_all_rounded,
                  size: AppButtonSize.sm,
                  onPressed: () => amountController.text = formatCurrency(
                    parseAmount(widget.debtPrice).toInt().toString(),
                    withCurrency: false,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            AppButton.secondary(
              label: tr("cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            AppButton(
              label: tr("add_payment"),
              icon: Icons.check_circle_rounded,
              loading: loading,
              onPressed: _submit,
            ),
          ],
        );
      },
    );
  }
}
