import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/create_inventory_count_payload.dart';

final class CreateInventoryCountRequest
    extends RemoteRequest<CreateInventoryCountPayload> {
  final String note;

  CreateInventoryCountRequest.fromPayload(super.payload)
      : note = payload.note,
        super.fromPayload();

  @override
  Json data() => {
        "note": note,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
