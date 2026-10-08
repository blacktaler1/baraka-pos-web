import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';
import '../blocs/create_loan_bloc/create_loan_bloc.dart';
import '../blocs/loan_debt_bloc/loan_debt_bloc.dart';

Future<void> showLoanPanel(
  BuildContext context, {
  required int firmaId,
  required bool isDebt,
}) {
  return showAppSidePanel(
    context,
    builder: (_) => LoanFormPanel(firmaId: firmaId, isDebt: isDebt),
  );
}

class LoanFormPanel extends StatefulWidget {
  final int firmaId;
  final bool isDebt;

  const LoanFormPanel({super.key, required this.firmaId, required this.isDebt});

  @override
  State<LoanFormPanel> createState() => _LoanFormPanelState();
}

class _LoanFormPanelState extends State<LoanFormPanel> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _amount = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final amount = parseAmountInt(_amount.text);
    context.read<CreateLoanBloc>().add(
          CreateLoanStarted(
            title: _title.text,
            firmaId: widget.firmaId,
            debt: widget.isDebt ? amount : 0,
            paid: widget.isDebt ? 0 : amount,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final label = widget.isDebt ? tr("add_debt") : tr("add_payment");
    return BlocConsumer<CreateLoanBloc, CreateLoanState>(
      listener: (context, state) {
        state.whenOrNull(success: (_) {
          Navigator.of(context).pop();
          context.read<LoanDebtBloc>().add(LoanDebtStarted(
                search: "",
                cursor: "",
                pageSize: 10,
                debt: widget.isDebt,
                firmaId: widget.firmaId,
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('payment_success'.tr())),
          );
        });
      },
      builder: (context, state) {
        final loading =
            state.maybeWhen(inPrepare: () => true, orElse: () => false);
        return AppSidePanel(
          title: label,
          icon: widget.isDebt ? Icons.post_add_rounded : Icons.add_card_rounded,
          iconColor: widget.isDebt ? AppColors.danger : AppColors.success,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  label: tr("description"),
                  hint: tr("enter_description"),
                  controller: _title,
                  prefix: const Icon(Icons.notes_rounded, size: 18),
                ),
                const AppFormGap(),
                AppTextField(
                  label: widget.isDebt
                      ? tr("debt_amount")
                      : tr("payment_amount_short"),
                  required: true,
                  hint: tr("enter_amount"),
                  controller: _amount,
                  prefix: const Icon(Icons.payments_rounded, size: 18),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorFormatter(),
                  ],
                  validator: (v) =>
                      (v == null || v.isEmpty) ? tr("field_required") : null,
                ),
              ],
            ),
          ),
          actions: [
            AppButton.secondary(
              label: tr("cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            AppButton(
              label: label,
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
