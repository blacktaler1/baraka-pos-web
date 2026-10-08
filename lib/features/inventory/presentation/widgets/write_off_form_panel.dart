import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/domain/model/cash_product_model.dart';
import '../../domain/domain.dart';
import '../blocs/blocs.dart';
import 'product_picker_field.dart';

const writeOffReasons = ["damaged", "expired", "lost", "other"];

Future<void> showWriteOffFormPanel(BuildContext context) {
  return showAppSidePanel(context, builder: (_) => const WriteOffFormPanel());
}

class WriteOffFormPanel extends StatefulWidget {
  const WriteOffFormPanel({super.key});

  @override
  State<WriteOffFormPanel> createState() => _WriteOffFormPanelState();
}

class _WriteOffFormPanelState extends State<WriteOffFormPanel> {
  final _lines = <(CashProductModel, TextEditingController)>[];
  final _noteCtrl = TextEditingController();
  String _reason = writeOffReasons.first;

  @override
  void dispose() {
    for (final (_, ctrl) in _lines) {
      ctrl.dispose();
    }
    _noteCtrl.dispose();
    super.dispose();
  }

  void _addProduct(CashProductModel product) {
    if (_lines.any((l) => l.$1.id == product.id)) return;
    setState(() => _lines.add((product, TextEditingController(text: "1"))));
  }

  void _submit() {
    final items = [
      for (final (product, ctrl) in _lines)
        if (parseAmount(ctrl.text) > 0)
          StockLineInput(
              productId: product.id, quantity: parseAmount(ctrl.text)),
    ];
    if (items.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(tr("add_products_first"))));
      return;
    }
    context.read<CreateWriteOffBloc>().add(CreateWriteOffStarted(
          reason: _reason,
          note: _noteCtrl.text.trim(),
          items: items,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateWriteOffBloc, CreateWriteOffState>(
      listener: (context, state) => state.whenOrNull(
        success: (_) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(tr("write_off_saved"))));
        },
        failure: (error) => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message))),
      ),
      builder: (context, state) => AppSidePanel(
        title: tr("new_write_off"),
        icon: Icons.outbox_rounded,
        iconColor: AppColors.danger,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDropdown<String>(
              label: tr("reason"),
              required: true,
              value: _reason,
              items: [
                for (final r in writeOffReasons)
                  DropdownMenuItem(value: r, child: Text(tr("reason_$r"))),
              ],
              onChanged: (v) => setState(() => _reason = v ?? _reason),
            ),
            const AppFormGap(),
            AppTextField(label: tr("note"), controller: _noteCtrl),
            const SizedBox(height: AppSpacing.xl),
            AppSectionHeader(title: tr("products")),
            const SizedBox(height: AppSpacing.sm),
            ProductPickerField(onSelected: _addProduct),
            const SizedBox(height: AppSpacing.sm),
            for (final line in _lines)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(line.$1.title, style: AppText.bodyStrong),
                          Text(
                            "${tr("in_stock")}: ${parseAmount(line.$1.stock)} ${line.$1.unit}",
                            style: AppText.caption,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: AppTextField(
                        controller: line.$2,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                        ],
                      ),
                    ),
                    AppIconButton(
                      icon: Icons.close_rounded,
                      tooltip: tr("delete"),
                      color: AppColors.textTertiary,
                      onPressed: () => setState(() {
                        _lines.remove(line);
                        line.$2.dispose();
                      }),
                    ),
                  ],
                ),
              ),
            if (_lines.isEmpty)
              EmptyState(
                icon: Icons.delete_sweep_rounded,
                message: tr("add_products_first"),
              ),
          ],
        ),
        actions: [
          AppButton.secondary(
            label: tr("cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          AppButton.danger(
            label: tr("write_off"),
            loading: state is CreateWriteOffPrepare,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
