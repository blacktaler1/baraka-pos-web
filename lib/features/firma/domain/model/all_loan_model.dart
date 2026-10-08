import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/domain/domain.dart';

final class AllLoanModel extends Model {
  final String next;
  final String previous;
  final int total;
  final LoanFirmaCollection data;

  const AllLoanModel({
    required this.next,
    required this.previous,
    required this.total,
    required this.data,
  });

  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "total: $total",
        "data: $data",
      ];
}
