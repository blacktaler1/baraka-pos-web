import 'package:baraka_pos/shared/domain/domain.dart';

import 'firma_collection.dart';

final class AllFirmaModel extends Model {
  final String next;
  final String previous;
  final int total;
  final FirmaCollection results;

  const AllFirmaModel({
    required this.next,
    required this.previous,
    required this.results,
    required this.total,
  });
  @override
  List<String> get props => [
        "next: $next",
        "previous: $previous",
        "data: $results",
        "total: $total",
      ];
}
