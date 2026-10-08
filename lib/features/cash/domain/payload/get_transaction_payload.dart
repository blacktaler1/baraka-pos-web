import '../../../../shared/domain/domain.dart';

final class GetTransactionPayload extends Payload {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;
  final String search;

  const GetTransactionPayload({
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
