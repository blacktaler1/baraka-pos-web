import 'package:baraka_pos/features/expenses/domain/domain.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class GetExpensesRequest extends RemoteRequest<GetExpensesPayload> {
  final String cursor;
  final String pageSize;

  GetExpensesRequest.fromPayload(super.payload)
      : cursor = payload.cursor,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        "cursor": cursor,
        "page_size": pageSize,
      };
}
