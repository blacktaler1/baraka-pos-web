import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class InventoryCountDto extends JsonDto<InventoryCountModel> {
  final Json json;

  const InventoryCountDto.fromJson(this.json) : super.fromJson(json);

  @override
  InventoryCountModel model() {
    return InventoryCountModel(
      id: json.integer("id"),
      status: json.text("status"),
      note: json.text("note"),
      userName: json.object("user").text("name"),
      created: json.text("created"),
      completedAt: json.text("completed_at"),
      itemsCount: json.integer("items_count"),
      items:
          InventoryItemCollectionDto.fromList(json.items("items")).collection(),
    );
  }
}
