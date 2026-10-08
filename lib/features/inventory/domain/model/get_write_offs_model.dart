import 'package:baraka_pos/shared/domain/domain.dart';

import 'write_off_collection.dart';

final class GetWriteOffsModel extends Model {
  final String next;
  final String previous;
  final int total;
  final WriteOffCollection data;

  const GetWriteOffsModel({
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
