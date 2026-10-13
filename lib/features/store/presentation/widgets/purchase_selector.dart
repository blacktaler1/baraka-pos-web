import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../../shared/design/design.dart';

/// Xarid holati: '' — belgilanmagan, paid — to'lab oldim, debt — qarzga oldim.
/// Tanlansa summa (tan narx x miqdor) firmaning to'lovlari yoki qarzlariga yoziladi.
class PurchaseTypeSelector extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  /// Firma tanlanmagan bo'lsa tanlov o'chiq
  final bool hasFirma;

  /// Summa hisoblanadigan maydonlar o'zgarsa qayta chiziladi
  final Listenable? listenable;
  final num Function() amount;

  const PurchaseTypeSelector({
    super.key,
    required this.value,
    required this.onChanged,
    required this.hasFirma,
    required this.amount,
    this.listenable,
  });

  @override
  Widget build(BuildContext context) {
    final options = [
      ('', tr("purchase_not_set"), Icons.remove_circle_outline_rounded),
      ('paid', tr("purchase_paid"), Icons.price_check_rounded),
      ('debt', tr("purchase_debt"), Icons.handshake_rounded),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tr("purchase_to_firma"), style: AppText.label),
        const SizedBox(height: AppSpacing.xxs),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final (key, label, icon) in options)
              ChoiceChip(
                selected: value == key,
                showCheckmark: false,
                avatar: Icon(icon,
                    size: 16,
                    color: value == key ? Colors.white : AppColors.ink),
                label: Text(label),
                labelStyle: AppText.small.copyWith(
                  color: value == key ? Colors.white : AppColors.ink,
                  fontWeight: FontWeight.w600,
                ),
                // Hover paytida ham tanlangan rang saqlansin
                color: WidgetStateProperty.resolveWith((states) =>
                    states.contains(WidgetState.selected)
                        ? AppColors.primary
                        : AppColors.surface),
                side: BorderSide(
                  color: value == key ? AppColors.primary : AppColors.border,
                ),
                onSelected: key.isEmpty || hasFirma
                    ? (_) => onChanged(key)
                    : null,
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        ListenableBuilder(
          listenable: listenable ?? const _Never(),
          builder: (context, _) {
            final String hint;
            if (!hasFirma) {
              hint = tr("purchase_needs_firma");
            } else if (value.isEmpty) {
              hint = tr("purchase_hint");
            } else {
              hint = tr(value == 'paid' ? "purchase_paid_hint" : "purchase_debt_hint",
                  args: [formatCurrency(amount().toStringAsFixed(0))]);
            }
            return Text(hint, style: AppText.caption);
          },
        ),
      ],
    );
  }
}

class _Never extends Listenable {
  const _Never();

  @override
  void addListener(VoidCallback listener) {}

  @override
  void removeListener(VoidCallback listener) {}
}
