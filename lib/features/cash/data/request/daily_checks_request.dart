import 'package:baraka_pos/features/cash/domain/payload/daily_checks_payload.dart';
import 'package:baraka_pos/shared/shared.dart';

final class DailyChecksRequest extends RemoteRequest<DailyChecksPayload> {
  final String from;
  final String to;

  DailyChecksRequest.fromPayload(super.payload)
      : from = payload.from,
        to = payload.to,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {
        if (from.isNotEmpty) "from": from,
        if (to.isNotEmpty) "to": to,
      };
}
