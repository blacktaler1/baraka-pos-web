import 'package:baraka_pos/shared/shared.dart';

import '../../domain/model/expense_category_model.dart';

final class ExpenseCategoryDto extends JsonDto<ExpenseCategoryModel> {
  final Json json;

  const ExpenseCategoryDto.fromJson(this.json) : super.fromJson(json);

  @override
  ExpenseCategoryModel model() {
    return ExpenseCategoryModel(
      id: json.integer("id"),
      title: json.text("title"),
      expensesCount: json.integer("expenses_count"),
      totalAmount: json.number("total_amount"),
    );
  }
}

final class ExpenseCategoriesDto extends JsonDto<ExpenseCategoriesModel> {
  final Json json;

  const ExpenseCategoriesDto.fromJson(this.json) : super.fromJson(json);

  @override
  ExpenseCategoriesModel model() {
    final uncategorized = json.object("uncategorized");
    return ExpenseCategoriesModel(
      categories: json
          .items("data")
          .whereType<Json>()
          .map((e) => ExpenseCategoryDto.fromJson(e).model())
          .toList(),
      uncategorizedCount: uncategorized.integer("expenses_count"),
      uncategorizedAmount: uncategorized.number("total_amount"),
    );
  }
}
