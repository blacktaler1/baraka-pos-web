import 'package:baraka_pos/features/cash/cash.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class CashProductRequest extends RemoteRequest<CashProductPayload> {
  final String search;
  final String category;
  final String cursor;
  final String pageSize;

  CashProductRequest.fromPayload(super.payload)
      : search = payload.search,
        category = payload.category,
        cursor = payload.cursor,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (search.isNotEmpty) 'search': search,
        if (category.isNotEmpty) 'category': category,
        if (cursor.isNotEmpty) 'cursor': cursor,
        if (pageSize.isNotEmpty) 'page_size': pageSize,
      };
}
