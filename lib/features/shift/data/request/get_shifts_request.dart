import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../domain/payload/get_shifts_payload.dart';

final class GetShiftsRequest extends RemoteRequest<GetShiftsPayload> {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;

  GetShiftsRequest.fromPayload(super.payload)
      : cursor = payload.cursor,
        pageSize = payload.pageSize,
        from = payload.from,
        to = payload.to,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (cursor.isNotEmpty) "cursor": cursor,
        "page_size": "$pageSize",
        if (from.isNotEmpty) "from": from,
        if (to.isNotEmpty) "to": to,
      };
}
