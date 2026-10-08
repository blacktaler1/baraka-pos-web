import 'package:baraka_pos/shared/domain/domain.dart';

final class CashProductPayload extends Payload {
  final String search;
  final String category;
  final String cursor;
  final String pageSize;

  const CashProductPayload({
    required this.search,
    required this.category,
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "category: $category",
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
