import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:baraka_pos/shared/design/design.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool readOnly;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final int maxLines;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool hasError;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.maxLines = 1,
    this.enabled = true,
    this.hasError = false,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    final errorBorder = OutlineInputBorder(
      borderRadius: AppRadius.control,
      borderSide: const BorderSide(color: AppColors.danger),
    );
    return TextField(
      controller: controller,
      readOnly: readOnly,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      style: AppText.body,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: hasError ? errorBorder : null,
        focusedBorder: hasError ? errorBorder : null,
      ),
    );
  }
}
