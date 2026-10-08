import 'package:baraka_pos/shared/domain/domain.dart';

import 'customer_collection.dart';

final class GetCustomerModel extends Model {
  final String next;
  final String previous;
  final int total;
  final CustomerCollection data;

  const GetCustomerModel({
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
