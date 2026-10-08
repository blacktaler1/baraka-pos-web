import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/remove_inventory_item_payload.dart';

final class RemoveInventoryItemRequest
    extends RemoteRequest<RemoveInventoryItemPayload> {
  final int countId;
  final int itemId;

  RemoveInventoryItemRequest.fromPayload(super.payload)
      : countId = payload.countId,
        itemId = payload.itemId,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
