import 'package:baraka_pos/shared/domain/domain.dart';

final class GetAllProductPayload extends Payload {
  final String search;
  final String category;
  final String cursor;
  final int pageSize;
  final int firmaId;
  final bool lowStrock;
  const GetAllProductPayload({
    required this.search,
    required this.category,
    required this.cursor,
    required this.pageSize,
    required this.firmaId,
    required this.lowStrock,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "category: $category",
        "cursor: $cursor",
        "page_size: $pageSize",
        "firma_id: $firmaId",
        "lowStrock: $lowStrock",
      ];
}
