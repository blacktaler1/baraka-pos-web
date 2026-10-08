import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:flutter_test/flutter_test.dart';

/// 2 ta 40 metrlik rulon: dona 400 000, metr 12 000
OrderItem roll({String stock = "2", bool byPiece = true, String meter = "12000"}) =>
    OrderItem(
      productId: 1,
      title: "Kabel",
      price: "400000",
      wholesalePrice: "360000",
      quantity: 1,
      stock: stock,
      unit: "roll",
      packSize: 40,
      meterPrice: meter,
      byPiece: byPiece,
    );

void main() {
  group("rulon qoldig'i", () {
    test("7 m sotilgandan keyin 1 dona + 33 m", () {
      expect(formatRollStock("1.825", 40), "1 dona + 33 m");
    });
    test("butun donalar va faqat metr", () {
      expect(formatRollStock("2", 40), "2 dona");
      expect(formatRollStock("0.5", 40), "20 m");
      expect(formatRollStock("1.766667", 30), "1 dona + 23 m");
    });
  });

  group("savat qatori", () {
    test("metr rejimida narx — metr narxi, chegara — jami metr", () {
      final item = roll();
      expect(item.isPieceSale, isTrue);
      expect(item.priceFor(wholesale: false), "12000");
      expect(item.maxQuantity, 80);
      expect(item.saleUnit, "metr");
    });

    test("dona rejimida narx — dona narxi, faqat butun donalar", () {
      final item = roll(stock: "1.825", byPiece: false);
      expect(item.isPieceSale, isFalse);
      expect(item.priceFor(wholesale: false), "400000");
      expect(item.maxQuantity, 1);
      expect(item.saleUnit, "dona");
    });

    test("metr narxi kiritilmagan bo'lsa dona narxi / metr", () {
      expect(roll(meter: "").priceFor(wholesale: false), "10000.00");
      expect(roll().priceFor(wholesale: true), "9000.00");
    });

    test("savat saqlanib, qayta tiklanadi", () {
      final restored = OrderItem.fromStorageJson(roll().toStorageJson());
      expect(restored.packSize, 40);
      expect(restored.byPiece, isTrue);
      expect(restored.meterPrice, "12000");
    });

    test("oddiy mahsulot o'zgarmaydi", () {
      final item = OrderItem(
          productId: 2, title: "Non", price: "4000", quantity: 1, stock: "5", unit: "dona");
      expect(item.isRoll, isFalse);
      expect(item.maxQuantity, 5);
      expect(item.priceFor(wholesale: false), "4000");
    });
  });

  test("metr sotuvi backendga is_piece bilan yuboriladi", () {
    expect(
      const CreateItemModel(productId: 1, quantity: "7.0", price: 12000, isPiece: true).toJson(),
      {"product_id": 1, "quantity": "7.0", "price": 12000, "is_piece": true},
    );
    expect(
      const CreateItemModel(productId: 1, quantity: "1.0").toJson().containsKey("is_piece"),
      isFalse,
    );
  });
}
