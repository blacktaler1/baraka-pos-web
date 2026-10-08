import 'package:baraka_pos/shared/shared.dart';

import '../../../cash/cash.dart';
import '../../domain/domain.dart';

final class TurnoverCardDto extends JsonDto<TurnoverCardModel> {
  final Json json;

  TurnoverCardDto.fromJson(this.json) : super.fromJson(json);

  String get next => json["next"] ?? "";

  String get previous => json["previous"] ?? "";

  int get total => json.integer("total");

  TransactionCollectionDto get data =>
      TransactionCollectionDto.fromList(json["data"] ?? []);

  @override
  TurnoverCardModel model() {
    return TurnoverCardModel(
      next: next,
      previous: previous,
      total: total,
      data: data.collection(),
    );
  }
}
