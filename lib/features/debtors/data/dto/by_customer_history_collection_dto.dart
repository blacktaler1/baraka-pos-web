import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/by_customer_history_collection.dart';
import '../../domain/model/by_customer_history_model.dart';
import 'by_customer_history_dto.dart';

final class ByCustomerHistoryCollectionDto extends JsonCollectionDto<
    ByCustomerHistoryDto, ByCustomerHistoryCollection, ByCustomerHistoryModel> {
  final Json json;

  ByCustomerHistoryCollectionDto.fromJson(this.json)
      : super.fromJson(
          json,
          (e) => ByCustomerHistoryDto.fromJson(e),
        );

  ByCustomerHistoryCollectionDto.fromList(List list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ByCustomerHistoryDto.fromJson(e),
        );

  @override
  ByCustomerHistoryCollection collection() {
    return ByCustomerHistoryCollection(
      models: items.map((e) => e.model()).toList(),
    );
  }
}
