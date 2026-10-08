import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/domain.dart';
import 'dto.dart';

final class GetInventoryCountsDto extends JsonDto<GetInventoryCountsModel> {
  final Json json;

  const GetInventoryCountsDto.fromJson(this.json) : super.fromJson(json);

  @override
  GetInventoryCountsModel model() {
    return GetInventoryCountsModel(
      next: json.text("next"),
      previous: json.text("previous"),
      total: json.integer("total"),
      data:
          InventoryCountCollectionDto.fromList(json.items("data")).collection(),
    );
  }
}
