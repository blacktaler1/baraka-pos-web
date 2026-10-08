import 'package:baraka_pos/features/cash/cash.dart';

import '../../../../shared/shared.dart';

final class TurnoverCardModel extends Model {
  final String next;
  final String previous;
  final int total;
  final TransactionCollection data;

  const TurnoverCardModel({
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
