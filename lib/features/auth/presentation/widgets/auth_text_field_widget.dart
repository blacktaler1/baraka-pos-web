import 'package:baraka_pos/shared/design/design.dart';
import 'package:flutter/material.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? icon;

  const AuthTextFieldWidget({
    this.icon,
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: label,
      required: true,
      controller: controller,
      obscure: isPassword,
      keyboardType: keyboardType,
      validator: validator,
      prefix: icon == null ? null : Icon(icon, size: 19),
    );
  }
}
