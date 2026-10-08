import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../aplication/configs/app_colors.dart';
import '../tokens.dart';

class AppFieldLabel extends StatelessWidget {
  final String text;
  final bool required;

  const AppFieldLabel(this.text, {super.key, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Text.rich(
        TextSpan(
          text: text,
          children: [
            if (required)
              const TextSpan(
                text: ' *',
                style: TextStyle(color: AppColors.danger),
              ),
          ],
        ),
        style: AppText.label,
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final String? helper;
  final bool required;
  final TextEditingController? controller;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscure;
  final bool readOnly;
  final bool enabled;
  final int maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final AutovalidateMode? autovalidateMode;
  final TextAlign textAlign;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.helper,
    this.required = false,
    this.controller,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.inputFormatters,
    this.obscure = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.onTap,
    this.autovalidateMode,
    this.textAlign = TextAlign.start,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null)
          AppFieldLabel(widget.label!, required: widget.required),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          validator: widget.validator,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          obscureText: _hidden,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.obscure ? 1 : widget.maxLines,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          autovalidateMode: widget.autovalidateMode,
          textAlign: widget.textAlign,
          style: AppText.body,
          decoration: InputDecoration(
            hintText: widget.hint,
            helperText: widget.helper,
            prefixIcon: widget.prefix,
            suffixIcon: widget.obscure
                ? IconButton(
                    onPressed: () => setState(() => _hidden = !_hidden),
                    icon: Icon(
                      _hidden
                          ? Icons.visibility_off_rounded
                          : Icons.visibility_rounded,
                      size: AppSizes.icon,
                    ),
                  )
                : widget.suffix,
          ),
        ),
      ],
    );
  }
}

class AppDropdown<T> extends StatelessWidget {
  final String? label;
  final String? hint;
  final bool required;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final FormFieldValidator<T>? validator;

  const AppDropdown({
    super.key,
    this.label,
    this.hint,
    this.required = false,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) AppFieldLabel(label!, required: required),
        DropdownButtonFormField<T>(
          key: ValueKey(value),
          initialValue: value,
          items: items,
          onChanged: onChanged,
          validator: validator,
          isExpanded: true,
          style: AppText.body,
          dropdownColor: AppColors.surface,
          borderRadius: AppRadius.control,
          iconSize: AppSizes.icon,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          hint: hint == null
              ? null
              : Text(
                  hint!,
                  style: AppText.body.copyWith(color: AppColors.textTertiary),
                ),
          isDense: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(14, 10, 10, 10),
          ),
        ),
      ],
    );
  }
}

class AppFormGap extends StatelessWidget {
  const AppFormGap({super.key});

  @override
  Widget build(BuildContext context) => const SizedBox(height: AppSpacing.md);
}

class AppFormRow extends StatelessWidget {
  final List<Widget> children;

  const AppFormRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final mobile = context.isMobile;
    if (mobile && children.length > 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            children[i],
          ],
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) SizedBox(width: mobile ? AppSpacing.sm : AppSpacing.md),
          Expanded(child: children[i]),
        ],
      ],
    );
  }
}

class AppFormSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const AppFormSection(
      {super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppText.h3),
        const SizedBox(height: AppSpacing.md),
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          children[i],
        ],
      ],
    );
  }
}
