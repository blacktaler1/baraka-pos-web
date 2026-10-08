import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../design/tokens.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? hintText;
  final double width;
  final FocusNode? focusNode;
  final Widget? suffix;

  const AppSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.hintText,
    this.width = AppSizes.searchWidth,
    this.focusNode,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: context.isMobile
          ? (width > screen - 2 * AppSpacing.sm
              ? screen - 2 * AppSpacing.sm
              : width)
          : width,
      height: AppSizes.controlHeight,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: AppText.body,
        decoration: InputDecoration(
          hintText: hintText ?? tr("search"),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
          suffixIcon: suffix,
        ),
      ),
    );
  }
}
