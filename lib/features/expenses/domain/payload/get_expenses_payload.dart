import 'package:baraka_pos/shared/shared.dart';

final class GetExpensesPayload extends Payload {
  final String cursor;
  final String pageSize;

  const GetExpensesPayload({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<String> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
