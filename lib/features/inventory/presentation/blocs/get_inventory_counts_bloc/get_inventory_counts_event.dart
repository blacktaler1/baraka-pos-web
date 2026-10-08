part of 'get_inventory_counts_bloc.dart';

sealed class GetInventoryCountsEvent extends Equatable {
  const GetInventoryCountsEvent();

  @override
  List<Object> get props => [];
}

final class GetInventoryCountsStarted extends GetInventoryCountsEvent {
  final String cursor;
  final int pageSize;

  const GetInventoryCountsStarted({
    required this.cursor,
    required this.pageSize,
  });

  @override
  List<Object> get props => [
        "cursor: $cursor",
        "pageSize: $pageSize",
      ];
}
