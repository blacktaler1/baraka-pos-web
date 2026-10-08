import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GrandTotalPanel extends StatelessWidget {
  final double grandTotal;
  final double subtotal;
  final double discount;

  const GrandTotalPanel({
    super.key,
    required this.grandTotal,
    this.subtotal = 0,
    this.discount = 0,
  });

  Widget _line(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
        child: Row(
          children: [
            Expanded(child: Text(label, style: AppText.caption)),
            Text(value, style: AppText.bodyMedium),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (discount > 0) ...[
          _line("sub_total".tr(), formatCurrency(subtotal.toStringAsFixed(0))),
          _line("discount".tr(),
              "− ${formatCurrency(discount.toStringAsFixed(0))}"),
        ],
        AppTotalBar(
          label: "grand_total".tr(),
          value: formatCurrency(grandTotal.toStringAsFixed(0)),
        ),
      ],
    );
  }
}
