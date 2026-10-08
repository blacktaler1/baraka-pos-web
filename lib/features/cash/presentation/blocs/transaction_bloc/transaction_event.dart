part of 'transaction_bloc.dart';

sealed class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

final class TransactionStarted extends TransactionEvent {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;
  final String search;

  const TransactionStarted({
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
