import 'package:baraka_pos/features/home/domain/payload/get_dashboard_payload.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class GetDashboardRequest extends RemoteRequest<GetDashboardPayload> {
  final String cardsPeriod;
  final String chartPeriod;
  final String topProductPeriod;
  GetDashboardRequest.fromPayload(super.payload)
      : cardsPeriod = payload.cardsPeriod,
        chartPeriod = payload.chartPeriod,
        topProductPeriod = payload.topProductPeriod,
        super.fromPayload();

  @override
  Json data() => {};

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
