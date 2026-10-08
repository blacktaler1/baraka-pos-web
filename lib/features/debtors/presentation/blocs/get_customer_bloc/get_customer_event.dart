part of 'get_customer_bloc.dart';

sealed class GetCustomerEvent extends Equatable {
  const GetCustomerEvent();

  @override
  List<Object> get props => [];
}

final class GetCustomerStarted extends GetCustomerEvent {
  final String search;
  final String pageSize;
  final String cursor;

  const GetCustomerStarted({
    required this.search,
    required this.pageSize,
    required this.cursor,
  });

  @override
  List<Object> get props => [
        "search: $search",
        "pageSize: $pageSize",
        "cursor: $cursor",
      ];
}
