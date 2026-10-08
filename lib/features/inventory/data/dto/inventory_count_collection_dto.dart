import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class InventoryCountCollectionDto extends JsonCollectionDto<
    InventoryCountDto, InventoryCountCollection, InventoryCountModel> {
  final Json json;

  InventoryCountCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => InventoryCountDto.fromJson(e));

  @override
  InventoryCountCollection collection() {
    return InventoryCountCollection(
        models: items.map((e) => e.model()).toList());
  }
}
