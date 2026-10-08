import 'package:baraka_pos/features/home/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

final class GetProfitRequest extends RemoteRequest<GetProfitCardPayload> {
  final String period;
  final String cursor;
  final int pageSize;
  GetProfitRequest.fromPayload(super.payload)
      : period = payload.period,
        cursor = payload.cursor,
        pageSize = payload.pageSize,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (period.isNotEmpty) 'period': period,
        if (cursor.isNotEmpty) 'cursor': cursor,
        if (pageSize > 0) 'page_size': pageSize.toString(),
      };
}
