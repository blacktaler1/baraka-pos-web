import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/get_write_offs_payload.dart';

final class GetWriteOffsRequest extends RemoteRequest<GetWriteOffsPayload> {
  final String cursor;
  final int pageSize;

  GetWriteOffsRequest.fromPayload(super.payload)
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
