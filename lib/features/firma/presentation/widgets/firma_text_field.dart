import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirmaTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscure;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final String label;
  final List<TextInputFormatter>? inputFormatters;

  const FirmaTextField({
    super.key,
    required this.controller,
    this.obscure = false,
    this.inputType = TextInputType.text,
    this.validator,
    this.onChanged,
    required this.label,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    final required = label.trimRight().endsWith('*');
    final cleanLabel = required
        ? label.trimRight().replaceFirst(RegExp(r'\s*\*$'), '')
        : label;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppTextField(
        label: cleanLabel,
        required: required,
        controller: controller,
        obscure: obscure,
        validator: validator,
        onChanged: onChanged,
        keyboardType: inputType,
        inputFormatters: [
          LengthLimitingTextInputFormatter(255),
          ...?inputFormatters,
        ],
      ),
    );
  }
}
