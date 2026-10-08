import 'package:baraka_pos/features/firma/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetLoanRequest extends RemoteRequest<GetLoanPayload> {
  final String search;
  final bool debt;
  final String cursor;
  final int pageSize;
  final int firmaId;

  GetLoanRequest.fromPayload(super.payload)
      : search = payload.search,
        debt = payload.debt,
        cursor = payload.cursor,
        pageSize = payload.pageSize,
        firmaId = payload.firmaId,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {
        'firma_id': firmaId.toString(),
      };

  @override
  Map<String, String> query() => {
        if (search.isNotEmpty) 'search': search,
        if (cursor.isNotEmpty) 'cursor': cursor,
        if (pageSize > 0) 'page_size': pageSize.toString(),
        'debt': debt.toString(),
      };
}
