import 'package:baraka_pos/shared/domain/domain.dart';

final class GetCustomerPayload extends Payload {
  final String search;
  final String pageSize;
  final String cursor;

  const GetCustomerPayload({
    required this.search,
    required this.pageSize,
    required this.cursor,
  });

  @override
  List<String> get props => [
        "search: $search",
        "pageSize: $pageSize",
        "cursor: $cursor",
      ];
}
