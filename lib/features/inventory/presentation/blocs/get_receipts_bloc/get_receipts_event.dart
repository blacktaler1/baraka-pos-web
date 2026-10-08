part of 'get_receipts_bloc.dart';

sealed class GetReceiptsEvent extends Equatable {
  const GetReceiptsEvent();

  @override
  List<Object> get props => [];
}

final class GetReceiptsStarted extends GetReceiptsEvent {
  final String cursor;
  final int pageSize;

  const GetReceiptsStarted({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
      ];
}
