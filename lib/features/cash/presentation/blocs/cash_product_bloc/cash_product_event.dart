part of 'cash_product_bloc.dart';

sealed class CashProductEvent extends Equatable {
  const CashProductEvent();

  @override
  List<Object> get props => [];
}

final class CashProductStarted extends CashProductEvent {
  final String search;
  final String category;
  final String cursor;
  final String pageSize;

  const CashProductStarted(
      {required this.search,
      required this.category,
      required this.cursor,
      required this.pageSize});

  @override
  List<Object> get props => [
        "search: $search",
        "category: $category",
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
