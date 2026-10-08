import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';

final class InventoryItemDto extends JsonDto<InventoryItemModel> {
  final Json json;

  const InventoryItemDto.fromJson(this.json) : super.fromJson(json);

  @override
  InventoryItemModel model() {
    return InventoryItemModel(
      id: json.integer("id"),
      productId: json.integer("product_id"),
      productTitle: json.text("product_title"),
      productUnit: json.text("product_unit"),
      barcode: json.text("barcode"),
      countedQuantity: json.text("counted_quantity", fallback: "0"),
      expectedQuantity: json.text("expected_quantity"),
      currentStock: json.text("current_stock", fallback: "0"),
      difference: json.text("difference", fallback: "0"),
      costPrice: json.text("cost_price"),
    );
  }
}
