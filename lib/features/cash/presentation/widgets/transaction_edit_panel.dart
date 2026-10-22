import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/aplication/configs/di/injection_container.dart';
import '../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/aplication/utils/safed.dart';
import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../../shared/aplication/utils/unit_utils.dart';
import '../../../../shared/data/sources/api_json_source.dart';
import '../../../../shared/design/design.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../domain/model/get_refund_model.dart';
import '../../domain/model/transaction_item_model.dart';
import '../../domain/model/transaction_model.dart';
import 'stock_refresh.dart';
import 'thousands_separator_formatter.dart';

/// Sotuv va vozvratni faqat admin tahrirlay oladi (backend ham tekshiradi)
bool get canEditSales => globalUser?.role == 'admin';

String _plain(Object? value) {
  final n = num.tryParse('$value') ?? 0;
  if (n == n.roundToDouble()) return n.toInt().toString();
  return n.toString().replaceFirst(RegExp(r'0+$'), '');
}

Future<Safed<BaseException, Json>> _editRequest(int id, Json body) =>
    sl<ApiJsonSource>()
        .post("/${globalUser?.warehouseUuid}/transaction/$id/edit/", body);

/// Sotuvni tahrirlash paneli. Saqlansa true qaytadi.
Future<bool?> showTransactionEditPanel(
    BuildContext context, TransactionModel transaction) {
  return showAppSidePanel<bool>(
    context,
    builder: (_) => _TransactionEditPanel(transaction: transaction),
  );
}

class _EditLine {
  final TransactionItemModel item;
  final TextEditingController qty;
  final TextEditingController price;
  bool removed = false;

  _EditLine(this.item)
      : qty = TextEditingController(text: _plain(item.quantity)),
        price = TextEditingController(
          text: formatCurrency(item.productPrice.toStringAsFixed(0),
              withCurrency: false),
        );

  num get quantity => num.tryParse(qty.text.replaceAll(',', '.')) ?? 0;
  num get unitPrice => parseAmount(price.text);
}

class _Customer {
  final int id;
  final String name;
  final String phone;

  const _Customer(this.id, this.name, this.phone);
}

class _TransactionEditPanel extends StatefulWidget {
  final TransactionModel transaction;

  const _TransactionEditPanel({required this.transaction});

  @override
  State<_TransactionEditPanel> createState() => _TransactionEditPanelState();
}

class _TransactionEditPanelState extends State<_TransactionEditPanel> {
  late final List<_EditLine> _lines =
      widget.transaction.items.models.map(_EditLine.new).toList();
  late String _method = widget.transaction.paymentMethod;
  late int? _customerId = widget.transaction.customerId;
  final _paidCtrl = TextEditingController(text: "0");
  List<_Customer> _customers = const [];
  bool _saving = false;

  TransactionModel get _txn => widget.transaction;
  bool get _wasDebt => _txn.paymentMethod == 'debt';

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  @override
  void dispose() {
    for (final line in _lines) {
      line.qty.dispose();
      line.price.dispose();
    }
    _paidCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    final result = await sl<ApiJsonSource>().get(
      "/${globalUser?.warehouseUuid}/debts/",
      params: {"page_size": "all"},
    );
    if (!mounted) return;
    result.when(
      success: (json) => setState(() {
        _customers = [
          for (final c in json.items("data").whereType<Json>())
            _Customer(c.integer("id"), c.text("full_name"), c.text("phone")),
        ];
      }),
      failure: (_) {},
    );
  }

  num get _itemsTotal => _lines
      .where((l) => !l.removed)
      .fold<num>(0, (sum, l) => sum + l.quantity * l.unitPrice);

  num get _newTotal {
    final discount = parseAmount(_txn.discount);
    final total = _itemsTotal - discount;
    return total < 0 ? 0 : total;
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message)));

  Future<void> _save() async {
    final kept = _lines.where((l) => !l.removed && l.quantity > 0).toList();
    if (kept.isEmpty) {
      _snack(tr("sale_needs_item"));
      return;
    }
    if (_method == 'debt' && _customerId == null) {
      _snack(tr("select_customer"));
      return;
    }
    final body = <String, dynamic>{
      "items": [
        for (final line in kept)
          {
            "id": line.item.id,
            "quantity": line.quantity.toString(),
            "price": line.unitPrice.toStringAsFixed(0),
          },
      ],
      "payment_method": _method,
      if (_method == 'debt') "customer": _customerId,
      if (_method == 'debt' && !_wasDebt)
        "paid_amount": parseAmount(_paidCtrl.text).toStringAsFixed(0),
    };

    setState(() => _saving = true);
    final result = await _editRequest(_txn.id, body);
    if (!mounted) return;
    result.when(
      success: (_) {
        refreshStockLists(context);
        Navigator.pop(context, true);
      },
      failure: (error) {
        setState(() => _saving = false);
        _snack(error.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSidePanel(
      title: tr("edit_sale"),
      subtitle: "${tr("receipt_no")}: ${_txn.transactionId}",
      icon: Icons.edit_note_rounded,
      iconColor: AppColors.info,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(tr("products_list"), style: AppText.h3),
          const SizedBox(height: AppSpacing.xs),
          for (final line in _lines)
            if (!line.removed) _lineEditor(line),
          const SizedBox(height: AppSpacing.lg),
          Text(tr("payment_type"), style: AppText.h3),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final (value, icon) in const [
                ('cash', Icons.payments_rounded),
                ('card', Icons.credit_card_rounded),
                ('debt', Icons.handshake_rounded),
              ])
                ChoiceChip(
                  selected: _method == value,
                  showCheckmark: false,
                  avatar: Icon(icon,
                      size: 16,
                      color: _method == value ? Colors.white : AppColors.ink),
                  label: Text(tr(value)),
                  labelStyle: AppText.small.copyWith(
                    color: _method == value ? Colors.white : AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                  // Hover paytida ham tanlangan rang saqlansin
                  color: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? AppColors.primary
                          : AppColors.surface),
                  side: BorderSide(
                    color:
                        _method == value ? AppColors.primary : AppColors.border,
                  ),
                  onSelected: (_) => setState(() => _method = value),
                ),
            ],
          ),
          if (_method == 'debt') ...[
            const SizedBox(height: AppSpacing.md),
            AppDropdown<int>(
              label: tr("customer"),
              required: true,
              hint: tr("select_customer"),
              value: _customers.any((c) => c.id == _customerId)
                  ? _customerId
                  : null,
              items: [
                for (final c in _customers)
                  DropdownMenuItem(
                    value: c.id,
                    child: Text(
                      c.phone.isEmpty ? c.name : "${c.name} · ${c.phone}",
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
              onChanged: (v) => setState(() => _customerId = v),
            ),
            if (!_wasDebt) ...[
              const SizedBox(height: AppSpacing.md),
              AppTextField(
                label: tr("paid_amount"),
                controller: _paidCtrl,
                prefix: const Icon(Icons.payments_rounded, size: 18),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter(),
                ],
              ),
            ] else if (parseAmount(_txn.debtPaid) > 0) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                "${tr("paid_amount")}: ${formatCurrency(_txn.debtPaid)}",
                style: AppText.small,
              ),
            ],
          ],
          const SizedBox(height: AppSpacing.lg),
          AppTotalBar(
            label: tr("total_payment"),
            value: formatCurrency(_newTotal.toStringAsFixed(0)),
          ),
        ],
      ),
      actions: [
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
    );
  }

  Widget _lineEditor(_EditLine line) {
    final item = line.item;
    final unit = saleQuantityLabel(
      quantity: 1,
      unit: item.productUnit,
      isPieceSale: item.isPieceSale,
      packSize: item.packSize,
    ).replaceFirst(RegExp(r'^1\s*'), '');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(item.productTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.bodyStrong),
              ),
              AppIconButton(
                icon: Icons.delete_rounded,
                tooltip: tr("delete"),
                color: AppColors.danger,
                onPressed: () => setState(() => line.removed = true),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: AppTextField(
                  label: "${tr("quantity")} ($unit)",
                  controller: line.qty,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppTextField(
                  label: tr("price"),
                  controller: line.price,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsSeparatorFormatter(),
                  ],
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}

/// Vozvrat miqdorlarini tahrirlash. Saqlansa true qaytadi.
Future<bool?> showRefundEditDialog(
    BuildContext context, GetRefundModel refund) {
  return showDialog<bool>(
    context: context,
    builder: (_) => _RefundEditDialog(refund: refund),
  );
}

class _RefundEditDialog extends StatefulWidget {
  final GetRefundModel refund;

  const _RefundEditDialog({required this.refund});

  @override
  State<_RefundEditDialog> createState() => _RefundEditDialogState();
}

class _RefundEditDialogState extends State<_RefundEditDialog> {
  late final Map<int, TextEditingController> _ctrls = {
    for (final item in widget.refund.items.models)
      item.id: TextEditingController(text: _plain(item.quantity)),
  };
  bool _saving = false;

  @override
  void dispose() {
    for (final c in _ctrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final refunds = [
      for (final item in widget.refund.items.models)
        if (num.tryParse(_ctrls[item.id]!.text.replaceAll(',', '.')) !=
            num.tryParse(item.quantity))
          {
            "id": item.id,
            "quantity":
                (num.tryParse(_ctrls[item.id]!.text.replaceAll(',', '.')) ?? 0)
                    .toString(),
          },
    ];
    if (refunds.isEmpty) {
      Navigator.pop(context);
      return;
    }
    setState(() => _saving = true);
    final result = await _editRequest(widget.refund.id, {"refunds": refunds});
    if (!mounted) return;
    result.when(
      success: (_) {
        refreshStockLists(context);
        Navigator.pop(context, true);
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
        constraints: const BoxConstraints(maxWidth: 460),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const AppSoftIcon(
                    icon: Icons.edit_note_rounded,
                    color: AppColors.info,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("edit_refund"), style: AppText.h2),
                        Text(widget.refund.transactionId, style: AppText.small),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(tr("edit_refund_hint"), style: AppText.caption),
              const SizedBox(height: AppSpacing.lg),
              for (final item in widget.refund.items.models) ...[
                AppTextField(
                  label: item.productTitle,
                  controller: _ctrls[item.id],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              const SizedBox(height: AppSpacing.md),
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
