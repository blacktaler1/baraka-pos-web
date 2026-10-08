import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CashRegisterNavbar extends StatelessWidget {
  const CashRegisterNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    context.locale;
    if (context.isMobile) return _buildMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E8A66), AppColors.primaryPressed],
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.point_of_sale_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(child: Text(tr("sales"), style: AppText.h1)),
            AppButton(
              label: tr("add_new_order"),
              icon: Icons.add_shopping_cart_rounded,
              onPressed: () => context.push("/cash_register"),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          children: [
            Expanded(
              child: _QuickLink(
                icon: Icons.receipt_long_rounded,
                color: AppColors.info,
                label: tr("transaction_history"),
                onTap: () => context.go("/transaction"),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _QuickLink(
                icon: Icons.assignment_return_rounded,
                color: AppColors.danger,
                label: tr("return_history"),
                onTap: () => context.go("/refund"),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _QuickLink(
                icon: Icons.manage_history_rounded,
                color: AppColors.warning,
                label: tr("cash_shifts"),
                onTap: () => context.go("/shifts"),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _QuickLink(
                icon: Icons.summarize_rounded,
                color: AppColors.success,
                label: tr("daily_receipt"),
                onTap: () => context.go("/daily_checks"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

extension on CashRegisterNavbar {
  /// Telefon: katta "Yangi savdo" tugmasi va 2x2 tezkor havolalar
  Widget _buildMobile(BuildContext context) {
    Widget link(IconData icon, Color color, String label, String path) =>
        _QuickLink(
          icon: icon,
          color: color,
          label: label,
          onTap: () => context.go(path),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 52,
          child: AppButton(
            label: tr("add_new_order"),
            icon: Icons.add_shopping_cart_rounded,
            expand: true,
            onPressed: () => context.push("/cash_register"),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: link(Icons.receipt_long_rounded, AppColors.info,
                  tr("transaction_history"), "/transaction"),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: link(Icons.assignment_return_rounded, AppColors.danger,
                  tr("return_history"), "/refund"),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Expanded(
              child: link(Icons.manage_history_rounded, AppColors.warning,
                  tr("cash_shifts"), "/shifts"),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: link(Icons.summarize_rounded, AppColors.success,
                  tr("daily_receipt"), "/daily_checks"),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickLink extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _QuickLink({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  State<_QuickLink> createState() => _QuickLinkState();
}

class _QuickLinkState extends State<_QuickLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.color;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: context.isMobile ? AppSpacing.xs : AppSpacing.md,
            vertical: context.isMobile ? AppSpacing.xs : AppSpacing.sm,
          ),
          transform: Matrix4.translationValues(0, _hovered ? -2 : 0, 0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _hovered ? c.withValues(alpha: 0.35) : AppColors.border,
            ),
            boxShadow: [
              BoxShadow(
                color: _hovered ? c.withValues(alpha: 0.12) : AppColors.shadow,
                blurRadius: _hovered ? 18 : 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      c.withValues(alpha: 0.16),
                      c.withValues(alpha: 0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: c.withValues(alpha: 0.12)),
                ),
                child: Icon(widget.icon, color: c, size: 21),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  widget.label,
                  maxLines: context.isMobile ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.isMobile ? AppText.label : AppText.bodyMedium,
                ),
              ),
              AnimatedSlide(
                duration: const Duration(milliseconds: 160),
                offset: Offset(_hovered ? 0.2 : 0, 0),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: _hovered ? c : AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
