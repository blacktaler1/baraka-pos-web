import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../../features/cash/domain/model/transaction_model.dart';
import '../../data/sources/pdf_receipt_service.dart';
import 'pdf_share_sheet.dart';

/// Savdo chekini PDF qilib yuborish oynasi (termal printer o'rniga)
Future<void> showReceiptShareSheet(
  BuildContext context,
  TransactionModel transaction, {
  String? title,
}) {
  return showPdfShareSheet(
    context,
    title: title ?? tr("receipt_ready"),
    subtitle: "${tr("receipt_no")}: ${transaction.transactionId}",
    fileName: "chek_${transaction.transactionId}.pdf",
    build: () => PdfReceiptService.buildReceipt(
      transaction: transaction,
      user: globalUser,
    ),
  );
}
