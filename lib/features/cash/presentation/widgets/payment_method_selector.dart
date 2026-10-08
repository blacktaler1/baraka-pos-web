import 'package:baraka_pos/app.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PaymentMethodSelector extends StatelessWidget {
  final String selectedPaymentMethod;
  final Function(String) onSelect;

  const PaymentMethodSelector({
    super.key,
    required this.selectedPaymentMethod,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final methods = [
      ("cash", "cash".tr(), Icons.payments_rounded),
      ("card", "card".tr(), Icons.credit_card_rounded),
      if (hasInternet)
        ("debt", "sell_on_credit".tr(), Icons.request_quote_rounded),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Icon(Icons.account_balance_wallet_rounded,
                size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.xs),
            Text("select_payment".tr(), style: AppText.h3),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            for (var i = 0; i < methods.length; i++) ...[
              if (i > 0) const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: _MethodTile(
                  label: methods[i].$2,
                  icon: methods[i].$3,
                  selected: selectedPaymentMethod == methods[i].$1,
                  onTap: () => onSelect(methods[i].$1),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _MethodTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _MethodTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      decoration: BoxDecoration(
        gradient: selected
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
              )
            : null,
        color: selected ? null : AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: selected ? Colors.transparent : AppColors.border,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: SizedBox(
            height: 72,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: selected
                        ? Colors.white.withValues(alpha: 0.18)
                        : AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 18,
                    color: selected ? Colors.white : AppColors.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: (selected ? AppText.bodyStrong : AppText.bodyMedium)
                      .copyWith(
                    fontSize: 13,
                    color: selected ? Colors.white : AppColors.ink,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
