import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../aplication/configs/app_colors.dart';
import '../../aplication/utils/currency_utils.dart';
import '../../aplication/utils/usd_rate.dart';
import '../tokens.dart';
import 'app_button.dart';
import 'app_fields.dart';

/// Pul maydoni yonidagi "$" tugmasi: dollarda yozilgan summani so'mga o'tkazadi
class UsdConvertButton extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onConverted;

  const UsdConvertButton(
      {super.key, required this.controller, this.onConverted});

  Future<void> _open(BuildContext context) async {
    final rate = await UsdRate.load();
    if (!context.mounted) return;
    if (rate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr("usd_rate_missing"))),
      );
      return;
    }
    final som = await showDialog<int>(
      context: context,
      builder: (_) => _UsdConvertDialog(rate: rate),
    );
    if (som == null) return;
    final text = formatCurrency(som.toString(), withCurrency: false);
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
    onConverted?.call(text);
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tr("usd_convert"),
      child: Padding(
        padding: const EdgeInsets.only(right: AppSpacing.xxs),
        child: Material(
          color: AppColors.successSoft,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            onTap: () => _open(context),
            child: const SizedBox(
              width: 34,
              height: 30,
              child: Center(
                child: Text(
                  r"$",
                  style: TextStyle(
                    fontFamily: 'Onest',
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: AppColors.success,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsdConvertDialog extends StatefulWidget {
  final double rate;

  const _UsdConvertDialog({required this.rate});

  @override
  State<_UsdConvertDialog> createState() => _UsdConvertDialogState();
}

class _UsdConvertDialogState extends State<_UsdConvertDialog> {
  final _ctrl = TextEditingController();
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Oyna ochilishi bilan darhol yozish mumkin bo'lsin
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _focus.dispose();
    _ctrl.dispose();
    super.dispose();
  }

  double? get _usd =>
      double.tryParse(_ctrl.text.replaceAll(' ', '').replaceAll(',', '.'));

  void _apply() {
    final usd = _usd;
    if (usd == null || usd <= 0) return;
    Navigator.pop(context, UsdRate.toSom(usd, widget.rate));
  }

  @override
  Widget build(BuildContext context) {
    final usd = _usd;
    final som = usd == null ? null : UsdRate.toSom(usd, widget.rate);
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(tr("usd_convert"), style: AppText.h2),
              Text(
                "1 \$ = ${formatCurrency(widget.rate.toStringAsFixed(widget.rate % 1 == 0 ? 0 : 2))}",
                style: AppText.small,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppTextField(
                label: tr("amount_in_usd"),
                controller: _ctrl,
                focusNode: _focus,
                usd: false,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                ],
                prefix: const Padding(
                  padding: EdgeInsets.only(left: 14, right: 6),
                  child: Text(r"$", style: AppText.bodyStrong),
                ),
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _apply(),
              ),
              const SizedBox(height: AppSpacing.md),
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.successSoft,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    Expanded(child: Text(tr("in_som"), style: AppText.small)),
                    Text(
                      som == null ? "—" : formatCurrency(som.toString()),
                      style: AppText.h3.copyWith(color: AppColors.success),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  AppButton.secondary(
                    label: tr("cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  AppButton(
                    label: tr("apply"),
                    icon: Icons.check_circle_rounded,
                    onPressed: som == null ? null : _apply,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
