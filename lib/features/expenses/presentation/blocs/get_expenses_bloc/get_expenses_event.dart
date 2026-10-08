part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}

final class GetExpensesStarted extends GetExpensesEvent {
  final String cursor;
  final String pageSize;

  const GetExpensesStarted({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
