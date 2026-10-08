import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/cancel_inventory_count_payload.dart';

final class CancelInventoryCountRequest
    extends RemoteRequest<CancelInventoryCountPayload> {
  final int id;

  CancelInventoryCountRequest.fromPayload(super.payload)
      : id = payload.id,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
