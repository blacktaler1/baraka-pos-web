import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/cash.dart';
import '../../domain/model/expense_model.dart';
import '../blocs/create_expense_bloc/create_expense_bloc.dart';
import '../blocs/update_expense_bloc/update_expense_bloc.dart';

Future<bool?> showExpensePanel(BuildContext context, {ExpenseModel? expense}) {
  return showAppSidePanel<bool>(
    context,
    builder: (_) => ExpenseFormPanel(expense: expense),
  );
}

class ExpenseFormPanel extends StatefulWidget {
  final ExpenseModel? expense;

  const ExpenseFormPanel({super.key, this.expense});

  @override
  State<ExpenseFormPanel> createState() => _ExpenseFormPanelState();
}

class _ExpenseFormPanelState extends State<ExpenseFormPanel> {
  final _formKey = GlobalKey<FormState>();
  late final _titleController =
      TextEditingController(text: widget.expense?.title ?? '');
  late final _amountController = TextEditingController(
    text: widget.expense?.amount.toString().split('.').first ?? '',
  );

  bool get _isEdit => widget.expense != null;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final title = _titleController.text.trim();
    final amount = parseAmountInt(_amountController.text);

    if (!_isEdit) {
      context
          .read<CreateExpenseBloc>()
          .add(CreateExpenseStarted(title: title, amount: amount));
      return;
    }

    final original = widget.expense!;
    final titleToUpdate = title == original.title ? "" : title;
    final amountToUpdate =
        amount == parseAmountInt(original.amount.split('.').first) ? 0 : amount;
    if (titleToUpdate.isEmpty && amountToUpdate == 0) {
      Navigator.pop(context);
      return;
    }
    context.read<UpdateExpenseBloc>().add(
          UpdateExpenseStarted(
            id: original.id,
            title: titleToUpdate,
            amount: amountToUpdate,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final loading =
        context.watch<CreateExpenseBloc>().state is CreateExpensePrepare ||
            context.watch<UpdateExpenseBloc>().state is UpdateExpensePrepare;

    return MultiBlocListener(
      listeners: [
        BlocListener<CreateExpenseBloc, CreateExpenseState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (_) {
                Navigator.pop(context, true);
                _snack(tr("successfully_added"));
              },
              failure: (error) => _snack(error.message),
            );
          },
        ),
        BlocListener<UpdateExpenseBloc, UpdateExpenseState>(
          listener: (context, state) {
            state.whenOrNull(
              success: (_) => Navigator.pop(context, true),
              failure: (error) => _snack(error.message),
            );
          },
        ),
      ],
      child: AppSidePanel(
        title: _isEdit ? tr("edit") : tr("add_new_expense"),
        subtitle: widget.expense?.title,
        icon: _isEdit ? Icons.edit_note_rounded : Icons.add_card_rounded,
        iconColor: AppColors.danger,
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextField(
                label: tr("title"),
                required: true,
                hint: tr("enter_title"),
                controller: _titleController,
                prefix: const Icon(Icons.label_rounded, size: 18),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? tr("field_required")
                    : null,
              ),
              const AppFormGap(),
              AppTextField(
                label: tr("amount"),
                required: true,
                hint: tr("enter_amount"),
                controller: _amountController,
                prefix: const Icon(Icons.payments_rounded, size: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter(),
                ],
                suffix: const Padding(
                  padding: EdgeInsets.only(right: AppSpacing.sm),
                  child: Center(
                    widthFactor: 1,
                    child: Text("so'm", style: AppText.small),
                  ),
                ),
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
            label: _isEdit ? tr("update") : tr("save"),
            icon: Icons.check_circle_rounded,
            loading: loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
