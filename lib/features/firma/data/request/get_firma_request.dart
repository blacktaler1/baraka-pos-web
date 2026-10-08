import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetFirmaRequest extends RemoteRequest<GetFirmaPayload> {
  final String search;
  final String cursor;
  final int pageSize;
  final bool? debt;

  GetFirmaRequest.fromPayload(super.payload)
      : search = payload.search,
        cursor = payload.cursor,
        pageSize = payload.pageSize,
        debt = payload.debt,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (search.isNotEmpty) 'search': search,
        if (cursor.isNotEmpty) 'cursor': cursor,
        if (pageSize > 0) 'page_size': pageSize.toString(),
        if (debt != null) 'debt': debt.toString(),
      };
}
