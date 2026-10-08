import 'package:baraka_pos/features/global/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:baraka_pos/shared/design/design.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/data/sources/pdf_receipt_service.dart';
import '../../../../shared/presentation/widgets/pdf_share_sheet.dart';
import 'product_add_sctock_widget.dart';

Future<void> showPrintBarcodePanel(
  BuildContext context, {
  required ProductModel product,
}) {
  return showAppSidePanel(
    context,
    builder: (_) => PrintBarcode(product: product),
  );
}

class PrintBarcode extends StatefulWidget {
  final ProductModel product;

  const PrintBarcode({super.key, required this.product});

  @override
  State<PrintBarcode> createState() => _PrintBarcodeState();
}

class _PrintBarcodeState extends State<PrintBarcode> {
  final amountController = TextEditingController(text: "1");

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> _print() async {
    final product = widget.product;
    final copies = parseAmountInt(amountController.text, fallback: 1);
    // Etiketkalar PDF ko'rinishida — telefondan printerga yoki chatga yuboriladi
    await showPdfShareSheet(
      context,
      title: tr("print_barcode"),
      subtitle: product.title,
      fileName: "barcode_${product.id}.pdf",
      icon: Icons.qr_code_2_rounded,
      build: () => PdfReceiptService.buildBarcodeLabels(
        productTitle: product.title,
        productId: product.id,
        barcode: product.qrCode,
        price: product.price,
        copies: copies,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSidePanel(
      title: tr("print_barcode"),
      icon: Icons.qr_code_scanner_rounded,
      iconColor: AppColors.gold,
      subtitle: widget.product.title,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductSummaryCard(product: widget.product),
          const SizedBox(height: AppSpacing.xl),
          AppTextField(
            label: tr("barcode_copies"),
            required: true,
            controller: amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onSubmitted: (_) => _print(),
          ),
        ],
      ),
      actions: [
        AppButton.secondary(
          label: tr("cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        AppButton(
          label: tr("send_pdf"),
          icon: Icons.ios_share_rounded,
          onPressed: _print,
        ),
      ],
    );
  }
}
