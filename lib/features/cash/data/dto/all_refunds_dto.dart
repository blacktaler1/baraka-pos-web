import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class AllRefundsDto extends JsonDto<AllRefundsModel> {
  final Json json;

  const AllRefundsDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  int get total => json.integer("total");

  GetRefundCollection get data {
    final raw = json["data"];
    return GetRefundCollectionDto.fromList(raw is List ? raw : []).collection();
  }

  @override
  AllRefundsModel model() {
    return AllRefundsModel(
      next: next,
      previous: previous,
      total: total,
      data: data,
    );
  }
}
