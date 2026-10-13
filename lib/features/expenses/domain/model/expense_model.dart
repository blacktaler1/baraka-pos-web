import 'package:baraka_pos/shared/domain/domain.dart';

final class ExpenseModel extends Model {
  final int id;
  final String created;
  final String modified;
  final String title;
  final String amount;
  final int warehouse;
  final int? categoryId;
  final String? categoryTitle;

  const ExpenseModel({
    required this.id,
    required this.created,
    required this.modified,
    required this.title,
    required this.amount,
    required this.warehouse,
    this.categoryId,
    this.categoryTitle,
  });

  @override
  List<String> get props => [
        "id: $id",
        "created: $created",
        "title: $title",
        "amount: $amount",
        "warehouse: $warehouse",
        "category: $categoryId",
      ];
}
