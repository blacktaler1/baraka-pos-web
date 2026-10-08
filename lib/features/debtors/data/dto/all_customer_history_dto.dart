import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/all_customer_history_model.dart';
import 'by_customer_history_collection_dto.dart';

final class AllCustomerHistoryDto extends JsonDto<AllCustomerHistoryModel> {
  final Json json;

  AllCustomerHistoryDto.fromJson(this.json) : super.fromJson(json);

  ByCustomerHistoryCollectionDto get data {
    final raw = json["data"];

    if (raw is List) {
      return ByCustomerHistoryCollectionDto.fromList(raw);
    }

    return ByCustomerHistoryCollectionDto.fromJson(raw);
  }

  @override
  AllCustomerHistoryModel model() {
    return AllCustomerHistoryModel(
      data: data.collection(),
    );
  }
}
