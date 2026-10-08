import 'package:baraka_pos/shared/domain/domain.dart';

final class GetRefundPayload extends Payload {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;
  final String search;

  const GetRefundPayload({
    required this.cursor,
    required this.pageSize,
    required this.from,
    required this.to,
    required this.search,
  });

  @override
  List<String> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
        "from: $from",
        "to: $to",
        "search: $search",
      ];
}
