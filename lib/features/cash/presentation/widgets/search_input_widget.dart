import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  final FocusNode searchFocusNode;
  final TextEditingController searchController;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final double width;

  const SearchInputWidget({
    super.key,
    required this.searchController,
    required this.onChanged,
    required this.searchFocusNode,
    this.onSubmitted,
    this.width = AppSizes.searchWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppSearchField(
      focusNode: searchFocusNode,
      controller: searchController,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintText: 'search_product'.tr(),
      width: width,
    );
  }
}
