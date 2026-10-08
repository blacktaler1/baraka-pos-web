import 'package:baraka_pos/features/workers/domain/domain.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WorkerPermissionsSection extends StatefulWidget {
  final WorkerPermissions value;
  final ValueChanged<WorkerPermissions> onChanged;

  const WorkerPermissionsSection({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<WorkerPermissionsSection> createState() =>
      _WorkerPermissionsSectionState();
}

class _WorkerPermissionsSectionState extends State<WorkerPermissionsSection> {
  late final _percentCtrl = TextEditingController(
    text: _formatPercent(widget.value.maxDiscountPercent),
  );

  static String _formatPercent(double value) =>
      value == value.roundToDouble() ? value.toInt().toString() : "$value";

  @override
  void dispose() {
    _percentCtrl.dispose();
    super.dispose();
  }

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: AppText.bodyMedium),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.value;
    return AppFormSection(
      title: tr("permissions"),
      children: [
        _toggle(
          tr("perm_can_discount"),
          value.canDiscount,
          (v) => widget.onChanged(value.copyWith(canDiscount: v)),
        ),
        if (value.canDiscount)
          AppTextField(
            label: tr("perm_max_discount"),
            controller: _percentCtrl,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,3}([.,]\d{0,2})?')),
            ],
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (v) {
              final parsed = double.tryParse((v ?? "").replaceAll(',', '.'));
              return parsed == null || parsed < 0 || parsed > 100
                  ? tr("perm_max_discount_invalid")
                  : null;
            },
            onChanged: (v) {
              final parsed = double.tryParse(v.replaceAll(',', '.'));
              if (parsed != null && parsed >= 0 && parsed <= 100) {
                widget.onChanged(value.copyWith(maxDiscountPercent: parsed));
              }
            },
          ),
        _toggle(
          tr("perm_can_edit_price"),
          value.canEditPrice,
          (v) => widget.onChanged(value.copyWith(canEditPrice: v)),
        ),
        _toggle(
          tr("perm_can_refund"),
          value.canRefund,
          (v) => widget.onChanged(value.copyWith(canRefund: v)),
        ),
      ],
    );
  }
}
