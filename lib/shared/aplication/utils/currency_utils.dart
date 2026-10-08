import 'package:easy_localization/easy_localization.dart';

double parseAmount(String? raw, {double fallback = 0}) {
  if (raw == null) return fallback;

  final cleaned = raw.replaceAll(RegExp(r'\s'), '').replaceAll(',', '.');

  return double.tryParse(cleaned) ?? fallback;
}

int parseAmountInt(String? raw, {int fallback = 0}) {
  return parseAmount(raw, fallback: fallback.toDouble()).toInt();
}

String formatCurrency(String amount, {bool withCurrency = true}) {
  try {
    // Stringni songa o'tkazamiz
    double value = double.parse(amount);

    // Agar nuqtadan keyin faqat 0 bo'lsa (masalan 2000.0), butun son qilib olamiz
    // Agar nuqtadan keyin haqiqiy qiymat bo'lsa (masalan 2000.50), uni saqlaymiz
    String formatted;
    if (value == value.toInt()) {
      // 200000.00 -> 200,000
      formatted = NumberFormat.decimalPattern('en_us').format(value.toInt());
    } else {
      // 200000.50 -> 200,000.50
      formatted = NumberFormat.decimalPattern('en_us').format(value);
    }

    formatted = formatted.replaceAll(",", " ");
    return withCurrency ? "$formatted ${tr("currency")}" : formatted;
  } catch (e) {
    return "$amount ${tr("currency")}";
  }
}
