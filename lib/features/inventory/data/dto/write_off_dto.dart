import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';

final class WriteOffDto extends JsonDto<WriteOffModel> {
  final Json json;

  const WriteOffDto.fromJson(this.json) : super.fromJson(json);

  @override
  WriteOffModel model() {
    return WriteOffModel(
      id: json.integer("id"),
      productTitle: json.text("product_title"),
      productUnit: json.text("product_unit"),
      barcode: json.text("barcode"),
      quantity: json.text("quantity", fallback: "0"),
      costPrice: json.text("cost_price", fallback: "0"),
      totalCost: json.text("total_cost", fallback: "0"),
      reason: json.text("reason"),
      note: json.text("note"),
      userName: json.object("user").text("name"),
      created: json.text("created"),
    );
  }
}
