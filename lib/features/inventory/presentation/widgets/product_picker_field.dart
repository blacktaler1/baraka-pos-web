import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:baraka_pos/shared/presentation/widgets/barcode_scanner_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cash/domain/model/cash_product_model.dart';
import '../../../cash/presentation/blocs/cash_product_bloc/cash_product_bloc.dart';

class ProductPickerField extends StatefulWidget {
  final ValueChanged<CashProductModel> onSelected;

  const ProductPickerField({super.key, required this.onSelected});

  @override
  State<ProductPickerField> createState() => _ProductPickerFieldState();
}

class _ProductPickerFieldState extends State<ProductPickerField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<CashProductModel> get _products =>
      context.read<CashProductBloc>().state.maybeWhen(
            success: (model) => model.data.models,
            orElse: () => const <CashProductModel>[],
          );

  void _select(CashProductModel product) {
    widget.onSelected(product);
    _controller.clear();
    _focusNode.requestFocus();
  }

  void _submit(String value, VoidCallback pickHighlighted) {
    final code = value.trim();
    final exact = _products.where((p) => p.qrcode.trim() == code);
    if (code.isNotEmpty && exact.isNotEmpty) {
      _select(exact.first);
    } else {
      pickHighlighted();
    }
  }

  /// Kamera bilan o'qilgan shtrix-kod bo'yicha mahsulotni tanlash
  void _onScanned(String code) {
    final match = _products.where((p) => p.qrcode.trim() == code.trim());
    if (match.isNotEmpty) {
      _select(match.first);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${tr("cassa_not_found")} $code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final field = _buildField(context);
    if (!context.isMobile) return field;
    return Row(
      children: [
        Expanded(child: field),
        const SizedBox(width: AppSpacing.xs),
        ScanBarcodeButton(onScanned: _onScanned),
      ],
    );
  }

  Widget _buildField(BuildContext context) {
    return RawAutocomplete<CashProductModel>(
      textEditingController: _controller,
      focusNode: _focusNode,
      displayStringForOption: (p) => p.title,
      optionsBuilder: (value) {
        final query = value.text.trim().toLowerCase();
        if (query.isEmpty) return const [];
        return _products
            .where((p) =>
                p.title.toLowerCase().contains(query) ||
                p.qrcode.toLowerCase().contains(query))
            .take(20);
      },
      onSelected: _select,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) =>
          AppTextField(
        controller: controller,
        focusNode: focusNode,
        hint: tr("search_or_scan_product"),
        prefix: const Icon(Icons.qr_code_scanner_rounded, size: 18),
        onSubmitted: (value) => _submit(value, onFieldSubmitted),
      ),
      optionsViewBuilder: (context, onSelected, options) => Align(
        alignment: Alignment.topLeft,
        child: Material(
          elevation: 4,
          borderRadius: AppRadius.control,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 280, maxWidth: 520),
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                for (final p in options)
                  ListTile(
                    dense: true,
                    title: Text(p.title, style: AppText.bodyMedium),
                    subtitle: Text(
                      "${p.qrcode} · ${tr("in_stock")}: ${parseAmount(p.stock)}",
                      style: AppText.caption,
                    ),
                    trailing:
                        Text(formatCurrency(p.price), style: AppText.caption),
                    onTap: () => onSelected(p),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
