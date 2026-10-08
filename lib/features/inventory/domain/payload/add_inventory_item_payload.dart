import 'package:baraka_pos/shared/domain/domain.dart';

final class AddInventoryItemPayload extends Payload {
  final int countId;
  final int productId;
  final double countedQuantity;
  final String mode;

  const AddInventoryItemPayload({
    required this.countId,
    required this.productId,
    required this.countedQuantity,
    required this.mode,
  });

  @override
  List<String> get props => [
        "countId: $countId",
        "productId: $productId",
        "countedQuantity: $countedQuantity",
        "mode: $mode",
      ];
}
