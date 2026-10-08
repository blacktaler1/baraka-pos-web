typedef Json = Map<String, dynamic>;
typedef JsonList = List<Json>;

extension SafeJsonRead on Json {
  String text(String key, {String fallback = ""}) =>
      this[key]?.toString() ?? fallback;

  int integer(String key, {int fallback = 0}) {
    final value = this[key];
    if (value is num) return value.toInt();
    if (value is String) return num.tryParse(value)?.toInt() ?? fallback;
    return fallback;
  }

  num number(String key, {num fallback = 0}) {
    final value = this[key];
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? fallback;
    return fallback;
  }

  double decimal(String key, {double fallback = 0}) =>
      number(key, fallback: fallback).toDouble();

  bool flag(String key, {bool fallback = false}) {
    final value = this[key];
    if (value is bool) return value;
    if (value is String) return value.toLowerCase() == "true";
    return fallback;
  }

  Json object(String key) {
    final value = this[key];
    return value is Json ? value : <String, dynamic>{};
  }

  List items(String key) {
    final value = this[key];
    return value is List ? value : const [];
  }
}
