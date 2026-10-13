import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/aplication/configs/di/injection_container.dart';
import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../../shared/data/sources/api_json_source.dart';
import '../../../../shared/design/design.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../../cash/presentation/widgets/thousands_separator_formatter.dart';

/// Sotuvsiz qarzni faqat admin va menejer kirita oladi (backend ham tekshiradi)
bool get canAddManualDebt =>
    globalUser?.role == 'admin' || globalUser?.role == 'manager';

/// Yangi qarzdor (mijoz) yaratish. Yaratilsa true qaytadi.
Future<bool?> showCreateDebtorDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (_) => const _DebtFormDialog(customerId: null, customerName: null),
  );
}

/// Mavjud mijozga sotuvsiz qarz qo'shish. Qo'shilsa true qaytadi.
Future<bool?> showAddDebtDialog(
  BuildContext context, {
  required int customerId,
  required String customerName,
}) {
  return showDialog<bool>(
    context: context,
    builder: (_) =>
        _DebtFormDialog(customerId: customerId, customerName: customerName),
  );
}

class _DebtFormDialog extends StatefulWidget {
  /// null — yangi mijoz yaratiladi
  final int? customerId;
  final String? customerName;

  const _DebtFormDialog({required this.customerId, required this.customerName});

  @override
  State<_DebtFormDialog> createState() => _DebtFormDialogState();
}

class _DebtFormDialogState extends State<_DebtFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  DateTime? _deadline;
  bool _saving = false;

  bool get _isNewCustomer => widget.customerId == null;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 10),
    );
    if (picked != null) {
      setState(() =>
          _deadline = DateTime(picked.year, picked.month, picked.day, 23, 59));
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    final amount = parseAmount(_amountCtrl.text);
    final debt = {
      if (_noteCtrl.text.trim().isNotEmpty)
        "description": _noteCtrl.text.trim(),
      if (_deadline != null) "deadline": _deadline!.toUtc().toIso8601String(),
    };
    final uuid = globalUser?.warehouseUuid;
    final api = sl<ApiJsonSource>();

    setState(() => _saving = true);
    final result = _isNewCustomer
        ? await api.post("/$uuid/debts/", {
            "full_name": _nameCtrl.text.trim(),
            "phone": _phoneCtrl.text.trim(),
            "address": _addressCtrl.text.trim(),
            if (amount > 0) "initial_debt": amount.toStringAsFixed(0),
            if (amount > 0) ...debt,
          })
        : await api.post("/$uuid/debts/${widget.customerId}/debts/", {
            "amount": amount.toStringAsFixed(0),
            ...debt,
          });
    if (!mounted) return;
    result.when(
      success: (_) => Navigator.pop(context, true),
      failure: (error) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deadline = _deadline;
    final showDebt = !_isNewCustomer || canAddManualDebt;
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    AppSoftIcon(
                      icon: _isNewCustomer
                          ? Icons.person_add_alt_1_rounded
                          : Icons.playlist_add_rounded,
                      color: AppColors.danger,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isNewCustomer ? tr("new_debtor") : tr("add_debt"),
                            style: AppText.h2,
                          ),
                          if (widget.customerName != null)
                            Text(widget.customerName!, style: AppText.small),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                if (_isNewCustomer) ...[
                  AppTextField(
                    label: tr("full_name"),
                    required: true,
                    controller: _nameCtrl,
                    prefix: const Icon(Icons.person_rounded, size: 18),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("field_required")
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    label: tr("phone"),
                    required: true,
                    controller: _phoneCtrl,
                    prefix: const Icon(Icons.call_rounded, size: 18),
                    keyboardType: TextInputType.phone,
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? tr("field_required")
                        : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    label: tr("address"),
                    controller: _addressCtrl,
                    prefix: const Icon(Icons.place_rounded, size: 18),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
                if (showDebt) ...[
                  AppTextField(
                    label: _isNewCustomer ? tr("initial_debt") : tr("amount"),
                    required: !_isNewCustomer,
                    helper: _isNewCustomer ? tr("initial_debt_hint") : null,
                    controller: _amountCtrl,
                    prefix: const Icon(Icons.account_balance_wallet_rounded,
                        size: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsSeparatorFormatter(),
                    ],
                    validator: (v) =>
                        !_isNewCustomer && parseAmount(v ?? "") <= 0
                            ? tr("field_required")
                            : null,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(tr("deadline"), style: AppText.label),
                  const SizedBox(height: AppSpacing.xxs),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton.secondary(
                          label: deadline == null
                              ? tr("no_deadline")
                              : DateFormat('dd.MM.yyyy').format(deadline),
                          icon: Icons.event_rounded,
                          onPressed: _pickDate,
                        ),
                      ),
                      if (deadline != null) ...[
                        const SizedBox(width: AppSpacing.xs),
                        AppIconButton(
                          icon: Icons.close_rounded,
                          tooltip: tr("no_deadline"),
                          onPressed: () => setState(() => _deadline = null),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AppTextField(
                    label: tr("note"),
                    controller: _noteCtrl,
                    maxLines: 2,
                  ),
                ],
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
      ),
    );
  }
}
