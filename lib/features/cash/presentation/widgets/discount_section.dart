import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../domain/model/mock_order.dart';
import 'thousands_separator_formatter.dart';

const _quickPercents = [5, 10, 15, 20];

class DiscountSection extends StatefulWidget {
  final MockOrder order;
  final double maxPercent;
  final void Function(double value, bool isPercent) onChanged;

  const DiscountSection({
    super.key,
    required this.order,
    required this.maxPercent,
    required this.onChanged,
  });

  @override
  State<DiscountSection> createState() => _DiscountSectionState();
}

class _DiscountSectionState extends State<DiscountSection> {
  late bool _isPercent = widget.order.discountIsPercent;
  late final _controller = TextEditingController(
    text: widget.order.discountValue == 0
        ? ""
        : _format(widget.order.discountValue),
  );
  String? _error;

  String _format(double value) => _isPercent
      ? (value == value.roundToDouble() ? value.toInt().toString() : "$value")
      : formatCurrency(value.toStringAsFixed(0), withCurrency: false);

  double get _maxAmount => widget.order.subtotal * widget.maxPercent / 100;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _apply(String raw) {
    final value =
        double.tryParse(raw.replaceAll(' ', '').replaceAll(',', '.')) ?? 0;
    final tooBig = _isPercent ? value > widget.maxPercent : value > _maxAmount;
    setState(() {
      _error = tooBig
          ? tr("discount_limit_exceeded", args: [
              _isPercent
                  ? "${_format(widget.maxPercent)}%"
                  : formatCurrency(_maxAmount.toStringAsFixed(0)),
            ])
          : null;
    });
    widget.onChanged(tooBig ? 0 : value, _isPercent);
  }

  void _switchMode(bool isPercent) {
    setState(() => _isPercent = isPercent);
    _controller.clear();
    _apply("");
  }

  void _quick(int percent) {
    setState(() => _isPercent = true);
    _controller.text = "$percent";
    _apply("$percent");
  }

  @override
  Widget build(BuildContext context) {
    final quick = _quickPercents.where((p) => p <= widget.maxPercent).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeader(
          title: tr("discount"),
          trailing: AppSegmentedControl<bool>(
            segments: {true: "%", false: tr("currency_uzs")},
            value: _isPercent,
            onChanged: _switchMode,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(
                  usd: false,
          controller: _controller,
          hint: tr("enter_discount"),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: _isPercent
              ? [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d{0,3}([.,]\d{0,2})?'))
                ]
              : [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorFormatter()
                ],
          suffix: Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: Text(_isPercent ? "%" : tr("currency_uzs"),
                style: AppText.caption),
          ),
          onChanged: _apply,
        ),
        if (_error != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(_error!,
              style: AppText.caption.copyWith(color: AppColors.danger)),
        ],
        if (quick.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            children: [
              for (final p in quick)
                AppButton.secondary(
                  label: "$p%",
                  size: AppButtonSize.sm,
                  onPressed: () => _quick(p),
                ),
            ],
          ),
        ],
      ],
    );
  }
}
