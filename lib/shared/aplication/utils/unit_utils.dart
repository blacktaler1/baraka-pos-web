import 'package:easy_localization/easy_localization.dart';

/// Rulon (metr) mahsulot: kabel, mato, shlang... Butun dona holida ham,
/// metrlab ham sotiladi. pack_size — 1 donadagi metr, qoldiq donada saqlanadi.
bool isRollUnit(String unit) => unit == 'roll';

String unitLabel(String unit) => switch (unit) {
      'roll' => tr('roll'),
      'pack' => tr('pack'),
      _ => unit,
    };

double _toDouble(Object? value) =>
    value is num ? value.toDouble() : double.tryParse('$value') ?? 0;

String _trim(double value) {
  final r = (value * 100).round() / 100;
  if (r == r.roundToDouble()) return r.toInt().toString();
  return r.toStringAsFixed(2).replaceFirst(RegExp(r'0+$'), '');
}

/// Rulon qoldig'i: 1.825 dona x 40 m -> "1 dona + 33 m"
String formatRollStock(Object? stock, int packSize) {
  final s = _toDouble(stock);
  if (packSize <= 0) return _trim(s);
  final pieces = (s + 1e-6).floor();
  var meters = (s - pieces) * packSize;
  if (meters < 0.005) meters = 0;
  final dona = tr('dona');
  if (pieces <= 0) return '${_trim(meters)} m';
  if (meters == 0) return '$pieces $dona';
  return '$pieces $dona + ${_trim(meters)} m';
}

/// Qoldiq birligi bilan: rulon uchun "1 dona + 33 m", boshqalar uchun "5 kg"
String formatStockWithUnit(Object? stock, String unit, int packSize) {
  if (isRollUnit(unit)) return formatRollStock(stock, packSize);
  return '${_trim(_toDouble(stock))} ${unitLabel(unit)}';
}

/// Sotilgan miqdor yozuvi: metrlab sotilgan bo'lsa "7 m"
String saleQuantityLabel({
  required Object? quantity,
  required String unit,
  required bool isPieceSale,
  required int packSize,
}) {
  final q = _trim(_toDouble(quantity));
  if (isRollUnit(unit)) return isPieceSale ? '$q m' : '$q ${tr('dona')}';
  if (unit == 'pack' && isPieceSale) return '$q ${tr('dona')}';
  final label = unitLabel(unit);
  final extra = unit == 'pack' && packSize > 0
      ? ' (${_trim(_toDouble(quantity) * packSize)} ${tr('dona')})'
      : '';
  return '$q $label$extra';
}
