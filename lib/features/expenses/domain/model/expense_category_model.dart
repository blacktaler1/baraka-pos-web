import 'package:baraka_pos/shared/domain/domain.dart';

final class ExpenseCategoryModel extends Model {
  final int id;
  final String title;
  final int expensesCount;
  final num totalAmount;

  const ExpenseCategoryModel({
    required this.id,
    required this.title,
    this.expensesCount = 0,
    this.totalAmount = 0,
  });

  @override
  List<String> get props => [
        "id: $id",
        "title: $title",
        "expenses_count: $expensesCount",
        "total_amount: $totalAmount",
      ];
}

/// Kategoriyalar ro'yxati va kategoriyasiz xarajatlar yig'indisi
final class ExpenseCategoriesModel extends Model {
  final List<ExpenseCategoryModel> categories;
  final int uncategorizedCount;
  final num uncategorizedAmount;

  const ExpenseCategoriesModel({
    required this.categories,
    required this.uncategorizedCount,
    required this.uncategorizedAmount,
  });

  @override
  List<String> get props => [
        "categories: $categories",
        "uncategorized_count: $uncategorizedCount",
        "uncategorized_amount: $uncategorizedAmount",
      ];
}
