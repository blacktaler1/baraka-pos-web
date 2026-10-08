part of 'get_firma_bloc.dart';

sealed class GetFirmaEvent extends Equatable {
  const GetFirmaEvent();

  @override
  List<Object> get props => [];
}

final class GetFirmaStarted extends GetFirmaEvent {
  final String search;
  final String cursor;
  final int pageSize;
  final bool debt;

  const GetFirmaStarted({
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
        "debt: $debt",
      ];
}
