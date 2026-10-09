import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dollar kursi (1 \$ = N so'm). Shu qurilmada saqlanadi, Sozlamalarda kiritiladi.
abstract final class UsdRate {
  static const _key = 'baraka_pos_usd_rate';

  /// null — kurs hali kiritilmagan
  static final ValueNotifier<double?> current = ValueNotifier(null);
  static bool _loaded = false;

  static Future<double?> load() async {
    if (_loaded) return current.value;
    try {
      final prefs = await SharedPreferences.getInstance();
      current.value = prefs.getDouble(_key);
    } catch (_) {}
    _loaded = true;
    return current.value;
  }

  static Future<void> save(double? rate) async {
    final prefs = await SharedPreferences.getInstance();
    if (rate == null || rate <= 0) {
      await prefs.remove(_key);
      current.value = null;
    } else {
      await prefs.setDouble(_key, rate);
      current.value = rate;
    }
    _loaded = true;
  }

  /// Dollarni so'mga o'tkazib, butun so'mgacha yaxlitlaydi: 59 000,78 -> 59 001
  static int toSom(double usd, double rate) => (usd * rate).round();
}
