import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/features/debtors/debtors.dart';
import 'package:baraka_pos/shared/aplication/utils/unit_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('qarz tovari o\'lchov birligi bilan: 1.000 o\'rniga 1', () {
    final item = ItemDto.fromJson({
      "id": 1,
      "quantity": "1.000",
      "price": "90000.00",
      "product_title": "K549",
      "product_unit": "dona",
      "subtotal": "90000.00",
      "is_piece_sale": false,
      "pack_size": null,
    }).model();
    expect(
      saleQuantityLabel(
        quantity: item.quantity,
        unit: item.productUnit,
        isPieceSale: item.isPieceSale,
        packSize: item.packSize,
      ),
      "1 dona",
    );
  });

  test('metrlab sotilgan qarz tovari', () {
    final item = ItemDto.fromJson({
      "id": 2,
      "quantity": "7.000",
      "product_unit": "roll",
      "is_piece_sale": true,
      "pack_size": 40,
    }).model();
    expect(item.isPieceSale, isTrue);
    expect(item.packSize, 40);
  });

  test('qo\'lda kiritilgan qarz: sotuv va tovarlarsiz', () {
    final debt = ByCustomerItemDto.fromJson({
      "id": 9,
      "paid": "0.00",
      "debt": "150000.00",
      "is_paid": false,
      "transaction_details": null,
      "items": [],
    }).model();
    expect(debt.details.transactionId, isEmpty);
    expect(debt.items.models, isEmpty);

    final receipt = debtReceiptFrom(
      customerName: "Vali",
      phone: "",
      debts: [debt],
    );
    expect(receipt.totalRemaining, 150000);
    expect(receipt.invoices.single.lines, isEmpty);
  });

  test('umumiy chek barcha qarzlarni qo\'shadi', () {
    ByCustomerItemModel debt(int id, String left, String paid) =>
        ByCustomerItemDto.fromJson({
          "id": id,
          "paid": paid,
          "debt": left,
          "items": [],
        }).model();
    final receipt = debtReceiptFrom(
      customerName: "Abror",
      phone: "998",
      debts: [debt(4, "5332500", "0"), debt(3, "325000", "25000")],
    );
    expect(receipt.totalRemaining, 5657500);
    expect(receipt.invoices.last.total, 350000);
    expect(receipt.invoices.last.paid, 25000);
  });

  test('sotuv: mijoz va to\'langan qarz o\'qiladi', () {
    final txn = const TransactionDto.fromJson({
      "id": 5,
      "payment_method": "debt",
      "customer": 7,
      "customer_name": "Ali",
      "debt_paid": "5000.00",
      "items": [],
    }).model();
    expect(txn.customerId, 7);
    expect(txn.customerName, "Ali");
    expect(txn.debtPaid, "5000.00");

    final cash = const TransactionDto.fromJson({"id": 6, "customer": null}).model();
    expect(cash.customerId, isNull);
  });

  test('vozvrat tovari tekis maydonlardan o\'qiladi', () {
    final item = TransactionItemDto.fromJson({
      "id": 30,
      "product_id": 2,
      "product_title": "Ruchka",
      "product_unit": "dona",
      "price": "2000.00",
      "quantity": "3.000",
      "subtotal": "6000.00",
    }).model();
    expect(item.productTitle, "Ruchka");
    expect(item.productId, 2);
    expect(item.productPrice, 2000);
  });
}
