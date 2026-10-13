import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../shared/aplication/utils/currency_utils.dart';
import '../../../../shared/aplication/utils/unit_utils.dart';
import '../../../../shared/data/sources/debt_receipt_data.dart';
import '../../../../shared/data/sources/pdf_receipt_service.dart';
import '../../../../shared/presentation/widgets/pdf_share_sheet.dart';
import '../../../auth/presentation/screens/splash_screen.dart';
import '../../domain/model/by_customer_item_debt_model.dart';

/// Qarz yozuvlarini chek ma'lumotiga aylantirish
DebtReceiptData debtReceiptFrom({
  required String customerName,
  required String phone,
  required List<ByCustomerItemModel> debts,
}) {
  return DebtReceiptData(
    customerName: customerName,
    phone: phone,
    invoices: [
      for (final debt in debts)
        DebtReceiptInvoice(
          label: "${tr("invoice")} #${debt.id}",
          date: _date(debt.details.created.isNotEmpty
              ? debt.details.created
              : debt.created),
          total: parseAmount(debt.paid) + parseAmount(debt.debt),
          paid: parseAmount(debt.paid),
          remaining: parseAmount(debt.debt),
          note: debt.description,
          lines: [
            for (final item in debt.items.models)
              DebtReceiptLine(
                title: item.productTitle,
                quantity: saleQuantityLabel(
                  quantity: item.quantity,
                  unit: item.productUnit,
                  isPieceSale: item.isPieceSale,
                  packSize: item.packSize,
                ),
                subtotal: item.subTotal,
              ),
          ],
        ),
    ],
  );
}

String _date(String raw) {
  final date = DateTime.tryParse(raw)?.toLocal();
  return date == null ? raw : DateFormat('dd.MM.yyyy').format(date);
}

/// Qarz chekini PDF qilib ulashish (webda termal printer yo'q)
Future<void> printDebtReceipt(
  BuildContext context, {
  required String customerName,
  required String phone,
  required List<ByCustomerItemModel> debts,
}) {
  final data =
      debtReceiptFrom(customerName: customerName, phone: phone, debts: debts);
  final suffix = debts.length == 1 ? "${debts.first.id}" : "umumiy";
  return showPdfShareSheet(
    context,
    title: tr("debt_receipt"),
    subtitle: customerName,
    fileName: "qarz_$suffix.pdf",
    build: () =>
        PdfReceiptService.buildDebtReceipt(data: data, user: globalUser),
  );
}
