import '../../../../shared/domain/domain.dart';

final class GetLoanPayload extends Payload {
  final String search;
  final bool debt;
  final String cursor;
  final int pageSize;
  final int firmaId;

  const GetLoanPayload({
    required this.search,
    required this.debt,
    required this.cursor,
    required this.pageSize,
    required this.firmaId,
  });

  @override
  List<String> get props => [
        "search: $search",
        "debt: $debt",
        "cursor: $cursor",
        "page_size: $pageSize",
        "id: $firmaId",
      ];
}
