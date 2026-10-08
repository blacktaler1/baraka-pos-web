part of 'debtor_firma_bloc.dart';

final class DebtorFirmaEvent extends Equatable {
  final String search;
  final String cursor;
  final int pageSize;
  final bool debt;

  const DebtorFirmaEvent({
    required this.search,
    required this.cursor,
    required this.pageSize,
    required this.debt,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "cursor: $cursor",
        "page_size: $pageSize",
        "debt: $debt",
      ];
}
