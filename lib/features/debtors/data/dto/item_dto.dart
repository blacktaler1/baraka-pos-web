import 'package:baraka_pos/features/debtors/domain/model/item_model.dart';
import 'package:baraka_pos/shared/shared.dart';

final class ItemDto extends JsonDto<ItemModel> {
  final Json json;

  ItemDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get quantity => json.text("quantity", fallback: "0");

  String get price => json.text("price", fallback: "0");

  String get productTitle => json.text("product_title");

  String get productUnit => json.text("product_unit");

  num get subTotal => json.number("subtotal");

  @override
  ItemModel model() {
    return ItemModel(
      id: id,
      quantity: quantity,
      price: price,
      productTitle: productTitle,
      productUnit: productUnit,
      subTotal: subTotal,
    );
  }
}
