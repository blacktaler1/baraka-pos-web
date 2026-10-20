import 'package:baraka_pos/shared/aplication/types/json.dart';

import '../../../../shared/data/data.dart';
import '../../domain/payload/product_history_payload.dart';

final class ProductHistoryRequest extends RemoteRequest<ProductHistoryPayload> {
  final int pk;
  final String type;
  final int offset;
  final int limit;

  ProductHistoryRequest.fromPayload(super.payload)
      : pk = payload.pk,
        type = payload.type,
        offset = payload.offset,
        limit = payload.limit,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (type.isNotEmpty) "type": type,
        "offset": "$offset",
        "limit": "$limit",
      };
}
