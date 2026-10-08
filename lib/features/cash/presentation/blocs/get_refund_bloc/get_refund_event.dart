part of 'get_refund_bloc.dart';

sealed class GetRefundEvent extends Equatable {
  const GetRefundEvent();

  @override
  List<Object> get props => [];
}

final class GetRefundStarted extends GetRefundEvent {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;
  final String search;

  const GetRefundStarted({
    required this.cursor,
    required this.pageSize,
    required this.from,
    required this.to,
    required this.search,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "page_size: $pageSize",
        "from: $from",
        "to: $to",
        "search: $search",
      ];
}
