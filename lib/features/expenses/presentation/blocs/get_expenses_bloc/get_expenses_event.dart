part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}

final class GetExpensesStarted extends GetExpensesEvent {
  final String cursor;
  final String pageSize;

  /// "" — hammasi, "none" — kategoriyasiz, aks holda kategoriya id
  final String category;

  const GetExpensesStarted({
    required this.cursor,
    required this.pageSize,
    this.category = "",
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
        "category: $category",
      ];
}
