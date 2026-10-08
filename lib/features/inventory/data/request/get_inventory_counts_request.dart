import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/get_inventory_counts_payload.dart';

final class GetInventoryCountsRequest
    extends RemoteRequest<GetInventoryCountsPayload> {
  final String cursor;
  final int pageSize;

  GetInventoryCountsRequest.fromPayload(super.payload)
      : cursor = payload.cursor,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (cursor.isNotEmpty) "cursor": cursor,
        "page_size": "$pageSize",
      };
}
