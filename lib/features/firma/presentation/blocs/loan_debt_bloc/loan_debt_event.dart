part of 'loan_debt_bloc.dart';

sealed class LoanDebtEvent extends Equatable {
  const LoanDebtEvent();

  @override
  List<Object> get props => [];
}

final class LoanDebtStarted extends LoanDebtEvent {
  final String search;
  final String cursor;
  final int pageSize;
  final int firmaId;
  final bool debt;

  const LoanDebtStarted({
    required this.search,
    required this.cursor,
    required this.pageSize,
    required this.firmaId,
    required this.debt,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "cursor: $cursor",
        "page_size: $pageSize",
        "id: $firmaId",
        "debt: $debt",
      ];
}
