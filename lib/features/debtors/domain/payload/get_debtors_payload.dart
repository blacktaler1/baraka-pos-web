import 'package:baraka_pos/shared/domain/domain.dart';

final class GetDebtorsPayload extends Payload {
  final bool? hasDebt;
  final bool? nearingDeadline;
  final String? search;
  final String? ordering;
  final String? pageSize;

  const GetDebtorsPayload({
    required this.hasDebt,
    required this.nearingDeadline,
    required this.search,
    required this.ordering,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "hasDebt: $hasDebt",
        "nearingDeadline: $nearingDeadline",
        "search: $search",
        "order: $ordering",
      ];
}
