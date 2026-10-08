import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';

final class ReceiptItemDto extends JsonDto<ReceiptItemModel> {
  final Json json;

  const ReceiptItemDto.fromJson(this.json) : super.fromJson(json);

  @override
  ReceiptItemModel model() {
    return ReceiptItemModel(
      id: json.integer("id"),
      productId: json.integer("product_id"),
      productTitle: json.text("product_title"),
      productUnit: json.text("product_unit"),
      barcode: json.text("barcode"),
      quantity: json.text("quantity", fallback: "0"),
      unitCost: json.text("unit_cost", fallback: "0"),
      newPrice: json.text("new_price"),
      totalCost: json.text("total_cost", fallback: "0"),
    );
  }
}
