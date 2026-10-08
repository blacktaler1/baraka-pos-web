import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/get_receipts_payload.dart';

final class GetReceiptsRequest extends RemoteRequest<GetReceiptsPayload> {
  final String cursor;
  final int pageSize;

  GetReceiptsRequest.fromPayload(super.payload)
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
