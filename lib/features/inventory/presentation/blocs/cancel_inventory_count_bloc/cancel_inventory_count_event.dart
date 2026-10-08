part of 'cancel_inventory_count_bloc.dart';

sealed class CancelInventoryCountEvent extends Equatable {
  const CancelInventoryCountEvent();

  @override
  List<Object> get props => [];
}

final class CancelInventoryCountStarted extends CancelInventoryCountEvent {
  final int id;

  const CancelInventoryCountStarted({
    required this.id,
  });

  @override
  List<Object> get props => [
        "id: $id",
      ];
}
