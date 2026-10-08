import 'package:baraka_pos/features/cash/presentation/widgets/search_input_widget.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CashRegisterHeader extends StatelessWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final Function(String) onSearchChange;
  final ValueChanged<String>? onSubmitted;

  const CashRegisterHeader({
    super.key,
    required this.onSearchChange,
    required this.searchFocusNode,
    required this.searchController,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      // Orqaga tugmasi va sarlavha telefonda yuqori tab panelida
      return SearchInputWidget(
        searchFocusNode: searchFocusNode,
        searchController: searchController,
        onChanged: onSearchChange,
        onSubmitted: onSubmitted,
        width: double.infinity,
      );
    }
    return Row(
      children: [
        AppBackButton(
          tooltip: tr("back_to_cash"),
          onTap: () => context.canPop() ? context.pop() : context.go("/cash"),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: AppPageHeader(
            icon: Icons.shopping_cart_checkout_rounded,
            title: "welcome_cash_screen".tr(),
            subtitle: DateFormat('dd.MM.yyyy').format(DateTime.now()),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        SearchInputWidget(
          searchFocusNode: searchFocusNode,
          searchController: searchController,
          onChanged: onSearchChange,
          onSubmitted: onSubmitted,
        ),
      ],
    );
  }
}
