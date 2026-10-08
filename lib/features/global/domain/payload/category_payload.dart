import 'package:baraka_pos/shared/domain/domain.dart';

final class CategoryPayload extends Payload {
  final String cursor;
  final String pageSize;

  const CategoryPayload({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor:$cursor",
        "page_size:$pageSize",
      ];
}
