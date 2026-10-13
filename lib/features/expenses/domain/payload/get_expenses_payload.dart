import 'package:baraka_pos/shared/shared.dart';

final class GetExpensesPayload extends Payload {
  final String cursor;
  final String pageSize;

  /// "" — hammasi, "none" — kategoriyasiz, aks holda kategoriya id
  final String category;

  const GetExpensesPayload({
    required this.cursor,
    required this.pageSize,
    this.category = "",
  });

  @override
  List<String> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
        "category: $category",
      ];
}
