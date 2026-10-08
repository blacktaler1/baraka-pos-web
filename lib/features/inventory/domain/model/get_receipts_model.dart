import 'package:baraka_pos/shared/domain/domain.dart';

import 'receipt_collection.dart';

final class GetReceiptsModel extends Model {
  final String next;
  final String previous;
  final int total;
  final ReceiptCollection data;

  const GetReceiptsModel({
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
