part of 'low_stock_bloc.dart';

final class LowStockEvent extends Equatable {
  final String search;
  final String category;
  final String cursor;
  final int pageSize;
  final int firmaId;
  final bool lowStock;

  const LowStockEvent({
    required this.search,
    required this.category,
    required this.cursor,
    required this.pageSize,
    required this.firmaId,
    required this.lowStock,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "category: $category",
        "cursor: $cursor",
        "page_size: $pageSize",
        "firma_id: $firmaId",
        "lowStock: $lowStock",
      ];
}
