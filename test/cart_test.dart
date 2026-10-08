import 'dart:convert';

import 'package:baraka_pos/features/cash/cash.dart';
import 'package:flutter_test/flutter_test.dart';

CashProductModel product({
  int id = 1,
  String price = "10000",
  String wholesalePrice = "",
  String stock = "50",
}) =>
    CashProductModel(
      id: id,
      title: "P$id",
      cost: "5000",
      price: price,
      wholesalePrice: wholesalePrice,
      stock: stock,
      categoryTitle: "",
      unit: "dona",
      packSize: 0,
      qrcode: "",
      warehouse: 1,
      images: "",
    );

Future<CartState> settle(CartBloc bloc) async {
  await Future<void>.delayed(Duration.zero);
  return bloc.state;
}

void main() {
  group('MockOrder totals', () {
    MockOrder order({double discount = 0, bool percent = true}) => MockOrder(
          transactionId: 1,
          discountValue: discount,
          discountIsPercent: percent,
          items: [
            OrderItem(
                productId: 1,
                title: "a",
                price: "10000",
                quantity: 2,
                stock: "9",
                unit: "dona"),
            OrderItem(
                productId: 2,
                title: "b",
                price: "5000",
                quantity: 1,
                stock: "9",
                unit: "dona"),
          ],
        );

    test('percent discount', () {
      final o = order(discount: 10);
      expect(o.subtotal, 25000);
      expect(o.discountAmount, 2500);
      expect(o.grandTotal, 22500);
    });

    test('sum discount never exceeds subtotal', () {
      expect(order(discount: 3000, percent: false).grandTotal, 22000);
      expect(order(discount: 99999, percent: false).grandTotal, 0);
    });

    test('storage json round trip keeps discount, wholesale and prices', () {
      final o = order(discount: 15).copyWith(wholesale: true);
      final restored = MockOrder.fromStorageJson(
        jsonDecode(jsonEncode(o.toStorageJson())) as Map<String, dynamic>,
      );
      expect(restored.wholesale, isTrue);
      expect(restored.discountValue, 15);
      expect(restored.items.length, 2);
      expect(restored.grandTotal, o.grandTotal);
    });
  });

  group('CartBloc', () {
    late CartBloc bloc;

    setUp(() async {
      bloc = CartBloc()..add(InitializeCart());
      await settle(bloc);
    });

    tearDown(() => bloc.close());

    test('wholesale toggle switches prices of items that have one', () async {
      bloc
        ..add(AddProductToOrderEvent(product(id: 1, wholesalePrice: "8000")))
        ..add(AddProductToOrderEvent(product(id: 2, price: "3000")))
        ..add(ToggleWholesaleEvent(true));
      var state = await settle(bloc);
      expect(state.selectedOrder!.items.map((i) => i.price), ["8000", "3000"]);
      expect(state.selectedOrder!.grandTotal, 11000);

      bloc.add(AddProductToOrderEvent(
          product(id: 3, wholesalePrice: "700", price: "1000")));
      state = await settle(bloc);
      expect(state.selectedOrder!.items.last.price, "700");

      bloc.add(ToggleWholesaleEvent(false));
      state = await settle(bloc);
      expect(state.selectedOrder!.items.map((i) => i.price),
          ["10000", "3000", "1000"]);
    });

    test('discount belongs to the selected order only', () async {
      bloc
        ..add(AddProductToOrderEvent(product()))
        ..add(UpdateDiscountEvent(value: 20, isPercent: true))
        ..add(AddNewOrderEvent())
        ..add(AddProductToOrderEvent(product()));
      final state = await settle(bloc);
      final byId = {for (final o in state.orders) o.transactionId: o};
      expect(byId[1]!.grandTotal, 8000);
      expect(byId[2]!.grandTotal, 10000);
    });
  });

  test('offline payload keeps debt details and discount', () {
    const payload = CreateTransactionPayload(
      paymentMethod: "debt",
      customer: 7,
      paidAmount: 1000,
      deadline: "2030-01-01",
      description: "note",
      discount: 500,
      items: CreateItemCollection(models: [
        CreateItemModel(productId: 1, quantity: "2", price: 10000),
      ]),
    );
    final restored = CreateTransactionPayload.fromJson(
      jsonDecode(jsonEncode(payload.toJson())) as Map<String, dynamic>,
    );
    expect(restored.customer, 7);
    expect(restored.paidAmount, 1000);
    expect(restored.deadline, "2030-01-01");
    expect(restored.description, "note");
    expect(restored.discount, 500);
    expect(restored.items.models.single.price, 10000);
  });
}
