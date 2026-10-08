import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/utils/currency_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../features/cash/domain/model/daily_checks_model.dart';
import 'local_sources.dart';

/// Termal printer o'rniga chekni 80 mm lentali PDF ko'rinishida tayyorlaydi
class PdfReceiptService {
  static pw.ThemeData? _theme;

  static Future<pw.ThemeData> _loadTheme() async {
    if (_theme != null) return _theme!;
    final regular =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Onest-Regular.ttf'));
    final bold =
        pw.Font.ttf(await rootBundle.load('assets/fonts/Onest-Bold.ttf'));
    return _theme = pw.ThemeData.withFont(base: regular, bold: bold);
  }

  static const _rollFormat = PdfPageFormat(
    80 * PdfPageFormat.mm,
    double.infinity,
    marginAll: 5 * PdfPageFormat.mm,
  );

  static final _money = NumberFormat('#,###', 'en_US');

  static String _fmt(String raw) {
    final n = num.tryParse(raw.replaceAll(RegExp(r'[^0-9.\-]'), ''));
    return n == null ? raw : _money.format(n).replaceAll(',', ' ');
  }

  static pw.Widget _line(String text,
          {bool bold = false, double size = 9, pw.TextAlign? align}) =>
      pw.Text(
        text,
        textAlign: align,
        style: pw.TextStyle(
          fontSize: size,
          fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
        ),
      );

  static pw.Widget _divider() => pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: pw.Divider(thickness: 0.6, borderStyle: pw.BorderStyle.dashed),
      );

  static pw.Widget _kv(String k, String v,
          {bool bold = false, double size = 9}) =>
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(child: _line(k, bold: bold, size: size)),
          pw.SizedBox(width: 6),
          _line(v, bold: bold, size: size),
        ],
      );

  /// Bir birlik narxi (metr yoki dona) — jami / miqdor
  static String _unitPrice(String subtotal, String quantity) {
    final q = parseAmount(quantity);
    return q == 0 ? subtotal : (parseAmount(subtotal) / q).toStringAsFixed(0);
  }

  static String _date(String raw) {
    final d = DateTime.tryParse(raw)?.toLocal();
    return d == null ? raw : DateFormat('dd.MM.yyyy HH:mm').format(d);
  }

  /// Savdo cheki
  static Future<Uint8List> buildReceipt({
    required TransactionModel transaction,
    required UserTableData? user,
  }) async {
    final doc = pw.Document(theme: await _loadTheme());
    final currency = 'currency_uzs'.tr();
    final phrase = user?.warehousePhrase ?? 'Sizga rahmat!';

    doc.addPage(
      pw.Page(
        pageFormat: _rollFormat,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            _line(user?.warehouseShopName ?? 'store_name'.tr(),
                bold: true, size: 15, align: pw.TextAlign.center),
            pw.SizedBox(height: 6),
            if ((user?.warehouseAddress ?? '').isNotEmpty)
              _line("${'address'.tr()}: ${user!.warehouseAddress}"),
            _line("${'cashier'.tr()}: ${transaction.cashier.name}"),
            _line("${'date'.tr()}: ${_date(transaction.created)}"),
            _line("${'transaction_id'.tr()}: ${transaction.transactionId}"),
            _divider(),
            for (final item in transaction.items.models)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    _line(item.productTitle, bold: true),
                    _kv(
                      "${saleQuantityLabel(quantity: item.quantity, unit: item.productUnit, isPieceSale: item.isPieceSale, packSize: item.packSize)}"
                      " x ${_fmt(_unitPrice(item.subtotal, item.quantity))}",
                      _fmt(item.subtotal),
                    ),
                  ],
                ),
              ),
            _divider(),
            if (parseAmount(transaction.discount) > 0)
              _kv('discount'.tr(), "${_fmt(transaction.discount)} $currency"),
            _kv(
              'grand_total'.tr().toUpperCase(),
              "${_fmt(transaction.totalSum)} $currency",
              bold: true,
              size: 12,
            ),
            pw.SizedBox(height: 2),
            _kv('paid'.tr(), transaction.paymentMethod.tr()),
            if ((user?.warehouseContact ?? '').isNotEmpty)
              _kv('contact'.tr(), user!.warehouseContact),
            pw.SizedBox(height: 10),
            _line("* $phrase *", bold: true, align: pw.TextAlign.center),
          ],
        ),
      ),
    );
    return doc.save();
  }

  /// Kunlik hisobot cheki
  static Future<Uint8List> buildDailyCheck({
    required DailyChecksModel dailyCheck,
    UserTableData? user,
  }) async {
    final doc = pw.Document(theme: await _loadTheme());
    final currency = 'currency_uzs'.tr();

    doc.addPage(
      pw.Page(
        pageFormat: _rollFormat,
        build: (_) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            _line(user?.warehouseShopName ?? 'store_name'.tr(),
                bold: true, size: 15, align: pw.TextAlign.center),
            pw.SizedBox(height: 6),
            _line("${'cashier'.tr()}: ${dailyCheck.user.name}"),
            if ((user?.warehouseAddress ?? '').isNotEmpty)
              _line("${'address'.tr()}: ${user!.warehouseAddress}"),
            _line("${'date'.tr()}: ${_date(dailyCheck.requestingTime)}"),
            _divider(),
            for (final item in dailyCheck.product.models)
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 4),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                  children: [
                    _line(item.productName, bold: true),
                    _kv("${item.quantity} ${item.unit}", _fmt(item.totalSales)),
                  ],
                ),
              ),
            _divider(),
            _kv('cash'.tr(), "${_fmt(dailyCheck.totalCash)} $currency"),
            _kv('card'.tr(), "${_fmt(dailyCheck.totalCard)} $currency"),
            _kv('debt'.tr(), "${_fmt(dailyCheck.totalDebt)} $currency"),
            pw.SizedBox(height: 2),
            _kv(
              'grand_total'.tr().toUpperCase(),
              "${_fmt(dailyCheck.totalSum)} $currency",
              bold: true,
              size: 12,
            ),
            if ((user?.warehouseContact ?? '').isNotEmpty) ...[
              pw.SizedBox(height: 6),
              _kv('contact'.tr(), user!.warehouseContact),
            ],
          ],
        ),
      ),
    );
    return doc.save();
  }

  /// Shtrix-kod etiketkalari (58x40 mm), har bir nusxa alohida sahifa
  static Future<Uint8List> buildBarcodeLabels({
    required String productTitle,
    required int productId,
    required String barcode,
    required String price,
    int copies = 1,
  }) async {
    final doc = pw.Document(theme: await _loadTheme());
    const format = PdfPageFormat(
      58 * PdfPageFormat.mm,
      40 * PdfPageFormat.mm,
      marginAll: 2.5 * PdfPageFormat.mm,
    );

    for (var i = 0; i < copies.clamp(1, 500); i++) {
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (_) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              _line(productTitle, bold: true, size: 8),
              _kv("ID: $productId", "${_fmt(price)} ${'currency_uzs'.tr()}",
                  size: 8, bold: true),
              pw.SizedBox(height: 3),
              pw.Expanded(
                child: barcode.isEmpty
                    ? pw.SizedBox()
                    : pw.BarcodeWidget(
                        barcode: pw.Barcode.code128(),
                        data: barcode,
                        textStyle: const pw.TextStyle(fontSize: 7),
                      ),
              ),
            ],
          ),
        ),
      );
    }
    return doc.save();
  }
}
