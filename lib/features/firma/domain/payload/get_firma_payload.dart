import '../../../../shared/domain/domain.dart';

final class GetFirmaPayload extends Payload {
  final String search;
  final String cursor;
  final int pageSize;
  final bool debt;

  const GetFirmaPayload({
    required this.search,
    required this.cursor,
    required this.pageSize,
    required this.debt,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "cursor: $cursor",
        "page_size: $pageSize",
      ];
}
