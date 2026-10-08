import 'package:baraka_pos/features/home/domain/domain.dart';

import '../../../../shared/shared.dart';

final class CardItemDto extends JsonDto<CardItemModel> {
  final Json json;

  CardItemDto.fromJson(this.json) : super.fromJson(json);

  double get value => json.decimal("amount");

  double get pct => json.decimal("percentage");

  @override
  CardItemModel model() {
    return CardItemModel(
      value: value,
      pct: pct,
    );
  }
}
