part of 'get_inventory_count_bloc.dart';

sealed class GetInventoryCountEvent extends Equatable {
  const GetInventoryCountEvent();

  @override
  List<Object> get props => [];
}

final class GetInventoryCountStarted extends GetInventoryCountEvent {
  final int id;

  const GetInventoryCountStarted({
    required this.id,
  });

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
