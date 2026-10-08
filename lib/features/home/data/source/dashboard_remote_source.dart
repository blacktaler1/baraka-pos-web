import 'package:baraka_pos/features/home/home.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../auth/auth.dart';

final class DashboardRemoteSource extends RemoteSource {
  DashboardRemoteSource({required super.client});

  Future<Safed<BaseException, DashboardDto>> getDashboard({
    required GetDashboardRequest request,
  }) async {
    return await apiGet(
      path:
          "/${globalUser?.warehouseUuid}/dashboard/?cards_period=${request.cardsPeriod}&chart_period=${request.chartPeriod}&top_products_period=${request.topProductPeriod}",
      request: request,
    ).map(
      success: dataFactory(DashboardDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, TurnoverCardDto>> getTurnoverCard({
    required GetTurnoverRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/dashboard/turnover/",
      request: request,
    ).map(
      success: dataFactory(TurnoverCardDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, TurnoverCardDto>> getProfitCard({
    required GetProfitRequest request,
  }) async {
    return await apiGet(
      path: "/${globalUser?.warehouseUuid}/dashboard/profit/",
      request: request,
    ).map(
      success: dataFactory(TurnoverCardDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
