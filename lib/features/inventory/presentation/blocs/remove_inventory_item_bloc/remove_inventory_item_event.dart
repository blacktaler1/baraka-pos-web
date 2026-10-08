part of 'remove_inventory_item_bloc.dart';

sealed class RemoveInventoryItemEvent extends Equatable {
  const RemoveInventoryItemEvent();

  @override
  List<Object> get props => [];
}

final class RemoveInventoryItemStarted extends RemoveInventoryItemEvent {
  final int countId;
  final int itemId;

  const RemoveInventoryItemStarted({
    required this.countId,
    required this.itemId,
  });

  @override
  List<Object> get props => [
        "countId: $countId",
        "itemId: $itemId",
      ];
}
