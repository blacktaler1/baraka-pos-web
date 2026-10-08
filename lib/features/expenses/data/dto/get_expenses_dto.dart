import 'package:baraka_pos/shared/shared.dart';

import '../../domain/model/expense_collection.dart';
import '../../domain/model/get_expenses_model.dart';
import 'expense_collection_dto.dart';

final class GetExpensesDto extends JsonDto<GetExpensesModel> {
  final Json json;

  const GetExpensesDto.fromJson(this.json) : super.fromJson(json);

  String get next => json.text("next");
  String get previous => json.text("previous");
  int get total => json.integer("total");
  num get totalAmount => json.number("total_amount");
  ExpenseCollection get data =>
      ExpenseCollectionDto.fromList(json.items("data")).collection();

  @override
  GetExpensesModel model() {
    return GetExpensesModel(
      next: next,
      previous: previous,
      total: total,
      totalAmount: totalAmount,
      data: data,
    );
  }
}
