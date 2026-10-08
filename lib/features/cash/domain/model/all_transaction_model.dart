import 'package:baraka_pos/features/cash/domain/model/transaction_collection.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class AllTransactionModel extends Model {
  final String next;
  final String previous;
  final int total;
  final double grandTotalSum;
  final double totalCash;
  final double totalCard;
  final double totalDebt;
  final TransactionCollection data;

  const AllTransactionModel({
    required this.next,
    required this.total,
    required this.grandTotalSum,
    required this.totalCash,
    required this.totalCard,
    required this.totalDebt,
    required this.previous,
    required this.data,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "total: $total",
        "grand_total_sum: $grandTotalSum",
        "total_cash: $totalCash",
        "total_card: $totalCard",
        "total_debt: $totalDebt",
        "data: $data",
      ];
}
