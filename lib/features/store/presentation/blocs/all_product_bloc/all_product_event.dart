part of 'all_product_bloc.dart';

final class AllProductEvent extends Equatable {
  final String search;
  final String category;
  final String cursor;
  final int pageSize;
  final int firmaId;
  final bool lowStock;

  const AllProductEvent({
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
