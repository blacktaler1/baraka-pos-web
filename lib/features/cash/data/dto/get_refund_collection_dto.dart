import 'package:baraka_pos/features/cash/cash.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../../../shared/data/data.dart';

final class GetRefundCollectionDto extends JsonCollectionDto<GetRefundDto,
    GetRefundCollection, GetRefundModel> {
  final Json json;

  GetRefundCollectionDto.fromJson(this.json)
      : super.fromJson(json, (e) => GetRefundDto.fromJson(e));

  GetRefundCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson({"data": list}, (e) => GetRefundDto.fromJson(e));

  @override
  GetRefundCollection collection() {
    return GetRefundCollection(models: items.map((e) => e.model()).toList());
  }
}
