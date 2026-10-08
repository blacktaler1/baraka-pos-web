import 'package:baraka_pos/features/home/data/data.dart';
import 'package:baraka_pos/features/home/domain/domain.dart';
import '../../../../shared/shared.dart';

final class CardsDto extends JsonDto<CardsModel> {
  final Json json;

  CardsDto.fromJson(this.json) : super.fromJson(json);

  CardItemDto get turnover => CardItemDto.fromJson(json.object("turnover"));

  CardItemDto get expenses => CardItemDto.fromJson(json.object("expenses"));

  CardItemDto get profit => CardItemDto.fromJson(json.object("profit"));

  CardItemDto get debt => CardItemDto.fromJson(json.object("debt"));

  @override
  CardsModel model() {
    return CardsModel(
      turnover: turnover.model(),
      expenses: expenses.model(),
      profit: profit.model(),
      debt: debt.model(),
    );
  }
}
