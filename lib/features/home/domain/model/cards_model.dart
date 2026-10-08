import 'package:baraka_pos/features/home/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class CardsModel extends Model {
  final CardItemModel turnover;
  final CardItemModel expenses;
  final CardItemModel profit;
  final CardItemModel debt;

  const CardsModel({
    required this.turnover,
    required this.expenses,
    required this.profit,
    required this.debt,
  });

  @override
  List<String> get props => [
        "turnover: $turnover",
        "expenses: $expenses",
        "profit: $profit",
        "debt: $debt",
      ];
}
