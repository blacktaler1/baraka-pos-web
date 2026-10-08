import 'package:baraka_pos/features/inventory/inventory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('inventory count detail parses items and nullable fields', () {
    final count = const InventoryCountDto.fromJson({
      "id": 3,
      "status": "draft",
      "note": "",
      "user": {"id": 1, "name": "Ali"},
      "created": "2026-10-04T10:00:00Z",
      "completed_at": null,
      "items_count": 1,
      "items": [
        {
          "id": 9,
          "product_id": 5,
          "product_title": "Oil",
          "product_unit": "dona",
          "barcode": "123",
          "counted_quantity": "8.000",
          "expected_quantity": null,
          "current_stock": "10.000",
          "difference": "-2.000",
          "cost_price": null,
        }
      ],
    }).model();

    expect(count.userName, "Ali");
    expect(count.completedAt, "");
    final item = count.items.models.single;
    expect(item.productId, 5);
    expect(item.difference, "-2.000");
    expect(item.expectedQuantity, "");
  });

  test('receipt parses firma, debt and lines', () {
    final receipt = const ReceiptDto.fromJson({
      "id": 1,
      "firma": {"id": 2, "title": "Supplier"},
      "user": {"name": "Ali"},
      "total_cost": "100000.00",
      "paid_amount": "30000.00",
      "debt": "70000.00",
      "items": [
        {"product_id": 5, "product_title": "Oil", "quantity": "10.000", "unit_cost": "10000.00", "new_price": null, "total_cost": "100000.00"}
      ],
    }).model();
    expect(receipt.firmaTitle, "Supplier");
    expect(receipt.debt, "70000.00");
    expect(receipt.items.models.single.newPrice, "");
  });

  test('stock line json omits empty prices', () {
    expect(const StockLineInput(productId: 1, quantity: 2).toJson(),
        {"product_id": 1, "quantity": 2.0});
  });
}
