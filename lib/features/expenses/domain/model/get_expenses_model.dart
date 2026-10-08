import 'package:baraka_pos/shared/domain/domain.dart';

import 'expense_collection.dart';

final class GetExpensesModel extends Model {
  final String next;
  final String previous;
  final int total;
  final num totalAmount;
  final ExpenseCollection data;

  const GetExpensesModel({
    required this.next,
    required this.previous,
    required this.total,
    required this.totalAmount,
    required this.data,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "total: $total",
        "total_amount: $totalAmount"
            "data: $data"
      ];
}
