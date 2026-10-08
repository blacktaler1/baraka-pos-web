import 'package:baraka_pos/shared/domain/domain.dart';

import 'get_refund_collection.dart';

final class AllRefundsModel extends Model {
  final String next;
  final String previous;
  final int total;
  final GetRefundCollection data;

  const AllRefundsModel({
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
