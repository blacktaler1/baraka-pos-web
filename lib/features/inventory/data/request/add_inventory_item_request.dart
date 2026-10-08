import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/add_inventory_item_payload.dart';

final class AddInventoryItemRequest
    extends RemoteRequest<AddInventoryItemPayload> {
  final int countId;
  final int productId;
  final double countedQuantity;
  final String mode;

  AddInventoryItemRequest.fromPayload(super.payload)
      : countId = payload.countId,
        productId = payload.productId,
        countedQuantity = payload.countedQuantity,
        mode = payload.mode,
        super.fromPayload();

  @override
  Json data() => {
        "product_id": productId,
        "counted_quantity": countedQuantity,
        "mode": mode,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
