import 'package:baraka_pos/shared/domain/domain.dart';

import 'inventory_count_collection.dart';

final class GetInventoryCountsModel extends Model {
  final String next;
  final String previous;
  final int total;
  final InventoryCountCollection data;

  const GetInventoryCountsModel({
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
