import 'package:baraka_pos/features/cash/presentation/widgets/thousands_separator_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc/cart_bloc.dart';
import 'custom_text_field.dart'; // verticalSpace uchun
import 'package:baraka_pos/shared/design/design.dart';

class DebtPaymentSection extends StatelessWidget {
  final CartState cartState; // O'zingizning CartState classingizni yozing
  final TextEditingController paidAmountController;
  final bool customerError;
  final bool deadlineError;
  final Function(BuildContext) onShowCustomerDialog;

  const DebtPaymentSection({
    super.key,
    required this.cartState,
    required this.paidAmountController,
    this.customerError = false,
    this.deadlineError = false,
    required this.onShowCustomerDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Mijoz tanlash qismi
        InkWell(
          onTap: () => onShowCustomerDialog(context),
          child: AbsorbPointer(
            child: CustomTextField(
              key: ValueKey(cartState.selectedCustomer?.id ?? 'no_customer'),
              hintText: cartState.selectedCustomer?.fullName ??
                  "select_customer".tr(),
              readOnly: true,
              hasError: customerError,
              suffixIcon: const Icon(Icons.keyboard_arrow_down),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Deadline (Muddat) tanlash
        InkWell(
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: cartState.debtDeadline ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
              locale: context.locale,
              helpText: tr("choose_date"),
            );

            if (picked != null && context.mounted) {
              context
                  .read<CartBloc>()
                  .add(UpdateDebtDetailsEvent(deadline: picked));
            }
          },
          child: AbsorbPointer(
            child: CustomTextField(
              hintText: cartState.debtDeadline != null
                  ? DateFormat('dd/MM/yyyy').format(cartState.debtDeadline!)
                  : tr("deadline"),
              readOnly: true,
              hasError: deadlineError,
              suffixIcon: const Icon(Icons.calendar_today_rounded, size: 18),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // Qarz sababi (Comment)
        CustomTextField(
          hintText: tr("debt_reason"),
          controller: TextEditingController(text: cartState.debtComment)
            ..selection =
                TextSelection.collapsed(offset: cartState.debtComment.length),
          onChanged: (value) => context.read<CartBloc>().add(
                UpdateDebtDetailsEvent(comment: value),
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        // To'langan summa
        CustomTextField(
          hintText: tr("paid_amount"),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            ThousandsSeparatorFormatter(),
          ],
          controller: paidAmountController,
          onChanged: (value) {
            final cleanValue = value.replaceAll(' ', '');
            context.read<CartBloc>().add(
                  UpdateDebtDetailsEvent(paidAmount: cleanValue),
                );
          },
        ),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }
}
