import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';
import '../../domain/model/expense_collection.dart';
import '../../domain/model/expense_model.dart';
import 'expense_dto.dart';

final class ExpenseCollectionDto
    extends JsonCollectionDto<ExpenseDto, ExpenseCollection, ExpenseModel> {
  final Json json;

  ExpenseCollectionDto.fromJson(this.json)
      : super.fromJson(json, (e) => ExpenseDto.fromJson(e));

  ExpenseCollectionDto.fromList(List<dynamic> list)
      : json = {"data": list},
        super.fromJson(
          {"data": list},
          (e) => ExpenseDto.fromJson(e),
        );

  @override
  ExpenseCollection collection() {
    return ExpenseCollection(models: items.map((e) => e.model()).toList());
  }
}
