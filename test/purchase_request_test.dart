import 'package:baraka_pos/features/global/domain/payload/create_product_payload.dart';
import 'package:baraka_pos/features/store/data/dto/product_dto.dart';
import 'package:baraka_pos/features/store/data/request/create_product_request.dart';
import 'package:baraka_pos/features/store/data/request/stock_update_request.dart';
import 'package:baraka_pos/features/store/domain/payload/stock_update_payload.dart';
import 'package:flutter_test/flutter_test.dart';

CreateProductPayload payload({String? purchase}) => CreateProductPayload(
      title: "Fanar",
      cost: 100000,
      price: 150000,
      stock: 10,
      categoryId: 1,
      unit: "dona",
      packSize: 0,
      imagesIds: const [],
      qrCode: "1",
      firmaId: 3,
      purchase: purchase,
    );

void main() {
  test('xarid holati faqat tanlanganda yuboriladi', () {
    expect(CreateProductRequest.fromPayload(payload()).data().containsKey("purchase"), isFalse);
    expect(CreateProductRequest.fromPayload(payload(purchase: "debt")).data()["purchase"], "debt");
  });

  test('zaxira: xarid va firmaga vozvrat', () {
    final add = StockUpdateRequest.fromPayload(
      const StockUpdatePayload(action: "add", amount: 5, pk: 1, purchase: "paid"),
    ).data();
    expect(add["purchase"], "paid");
    expect(add.containsKey("return_to_firma"), isFalse);

    final remove = StockUpdateRequest.fromPayload(
      const StockUpdatePayload(action: "remove", amount: 2, pk: 1, returnToFirma: true),
    ).data();
    expect(remove["return_to_firma"], isTrue);
    expect(remove.containsKey("purchase"), isFalse);
  });

  test('mahsulotning xarid holati o\'qiladi', () {
    final model = ProductDto.fromJson({"id": 1, "purchase_type": "debt"}).model();
    expect(model.purchaseType, "debt");
    expect(ProductDto.fromJson({"id": 2}).model().purchaseType, "");
  });
}
