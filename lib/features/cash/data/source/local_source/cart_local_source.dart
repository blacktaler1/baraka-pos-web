import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/model/mock_order.dart';

class SavedCarts {
  final List<MockOrder> orders;
  final int selectedOrderId;

  const SavedCarts({required this.orders, required this.selectedOrderId});
}

/// Ochiq savatlar brauzer xotirasida (localStorage) saqlanadi
class CartLocalSource {
  static const _key = 'baraka_pos_open_carts';

  Future<SavedCarts?> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      if (raw == null) return null;
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final orders = (json["orders"] as List)
          .map((e) => MockOrder.fromStorageJson(e as Map<String, dynamic>))
          .toList();
      if (orders.isEmpty) return null;
      return SavedCarts(
        orders: orders,
        selectedOrderId: json["selected_order_id"] as int,
      );
    } catch (_) {
      return null;
    }
  }

  Future<void> _lastWrite = Future.value();

  Future<void> save(List<MockOrder> orders, int selectedOrderId) {
    final content = jsonEncode({
      "selected_order_id": selectedOrderId,
      "orders": orders.map((e) => e.toStorageJson()).toList(),
    });
    return _lastWrite = _lastWrite.then((_) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_key, content);
    }).catchError((_) {});
  }
}
