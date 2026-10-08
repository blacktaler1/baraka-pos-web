import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TransactionSearchFilter extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearchChange;
  final DateTime? selectedFrom;
  final DateTime? selectedTo;
  final Function(DateTime start, DateTime end) onDateRangeSelected;
  final VoidCallback onReset;
  final VoidCallback onRefresh;
  final String? title;
  final IconData icon;

  const TransactionSearchFilter({
    this.title,
    this.icon = Icons.receipt_long_rounded,
    super.key,
    required this.searchController,
    required this.onSearchChange,
    required this.onDateRangeSelected,
    required this.onReset,
    required this.onRefresh,
    this.selectedFrom,
    this.selectedTo,
  });

  @override
  Widget build(BuildContext context) {
    final toolbar = AppToolbar(
      leading: [
        if (title == null)
          AppButton.secondary(
            label: tr("back_to_cash"),
            icon: Icons.arrow_back_ios_new_rounded,
            onPressed: () => context.go("/cash"),
          ),
        AppSearchField(
          controller: searchController,
          onChanged: onSearchChange,
          hintText: tr('search_product'),
        ),
      ],
      trailing: [
        AppDateRangeField(
          from: selectedFrom,
          to: selectedTo,
          onSelected: onDateRangeSelected,
          onClear: onReset,
        ),
        if (title == null)
          AppIconButton(
            icon: Icons.autorenew_rounded,
            tooltip: tr("refresh"),
            onPressed: onRefresh,
          ),
      ],
    );
    if (title == null) return toolbar;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppPageHeader(
          leading: AppBackButton(
            tooltip: tr("back_to_cash"),
            onTap: () => context.go("/cash"),
          ),
          icon: icon,
          title: title!,
          actions: [
            AppIconButton(
              icon: Icons.autorenew_rounded,
              tooltip: tr("refresh"),
              onPressed: onRefresh,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        toolbar,
      ],
    );
  }
}
