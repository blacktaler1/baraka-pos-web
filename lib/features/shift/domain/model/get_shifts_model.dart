import 'package:baraka_pos/shared/domain/domain.dart';

import 'cash_shift_collection.dart';

final class GetShiftsModel extends Model {
  final String next;
  final String previous;
  final int total;
  final CashShiftCollection data;

  const GetShiftsModel({
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
