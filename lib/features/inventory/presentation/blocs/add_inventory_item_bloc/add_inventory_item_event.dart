part of 'add_inventory_item_bloc.dart';

sealed class AddInventoryItemEvent extends Equatable {
  const AddInventoryItemEvent();

  @override
  List<Object> get props => [];
}

final class AddInventoryItemStarted extends AddInventoryItemEvent {
  final int countId;
  final int productId;
  final double countedQuantity;
  final String mode;

  const AddInventoryItemStarted({
    required this.countId,
    required this.productId,
    required this.countedQuantity,
    required this.mode,
  });

  @override
  List<Object> get props => [
        "countId: $countId",
        "productId: $productId",
        "countedQuantity: $countedQuantity",
        "mode: $mode",
      ];
}
