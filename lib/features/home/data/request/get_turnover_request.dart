import 'package:baraka_pos/features/home/home.dart';
import 'package:baraka_pos/shared/shared.dart';

final class GetTurnoverRequest extends RemoteRequest<GetTurnoverCardPayload> {
  final String period;
  final String cursor;
  final int pageSize;

  GetTurnoverRequest.fromPayload(super.payload)
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
        "period": period,
        "cursor": cursor,
        "page_size": pageSize.toString(),
      };
}
