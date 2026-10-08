import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetRefundRequest extends RemoteRequest<GetRefundPayload> {
  final String cursor;
  final int pageSize;
  final String from;
  final String to;
  final String search;

  GetRefundRequest.fromPayload(super.payload)
      : cursor = payload.cursor,
        pageSize = payload.pageSize,
        from = payload.from,
        to = payload.to,
        search = payload.search,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        "cursor": cursor,
        "page_size": pageSize.toString(),
        "from": from,
        "to": to,
        "search": search,
      };
}
