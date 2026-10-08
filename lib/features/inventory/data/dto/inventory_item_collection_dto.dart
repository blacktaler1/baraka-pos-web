import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class InventoryItemCollectionDto extends JsonCollectionDto<
    InventoryItemDto, InventoryItemCollection, InventoryItemModel> {
  final Json json;

  InventoryItemCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => InventoryItemDto.fromJson(e));

  @override
  InventoryItemCollection collection() {
    return InventoryItemCollection(
        models: items.map((e) => e.model()).toList());
  }
}
