import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class ReceiptDto extends JsonDto<ReceiptModel> {
  final Json json;

  const ReceiptDto.fromJson(this.json) : super.fromJson(json);

  @override
  ReceiptModel model() {
    return ReceiptModel(
      id: json.integer("id"),
      firmaTitle: json.object("firma").text("title"),
      userName: json.object("user").text("name"),
      note: json.text("note"),
      totalCost: json.text("total_cost", fallback: "0"),
      paidAmount: json.text("paid_amount", fallback: "0"),
      debt: json.text("debt", fallback: "0"),
      created: json.text("created"),
      items:
          ReceiptItemCollectionDto.fromList(json.items("items")).collection(),
    );
  }
}
