part of 'get_debtors_list_bloc.dart';

final class GetDebtorsListEvent extends Equatable {
  final bool? hasDebt;
  final bool? nearingDeadline;
  final String? search;
  final String? ordering;
  final String? pageSize;

  const GetDebtorsListEvent({
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
        "pageSize: $pageSize",
      ];
}
