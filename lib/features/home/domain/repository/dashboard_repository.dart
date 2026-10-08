import 'package:baraka_pos/features/home/domain/domain.dart';

import '../../../../shared/shared.dart';

abstract class DashboardRepository {
  Future<Safed<BaseException, DashboardModel>> getDashboard({
    required GetDashboardPayload payload,
  });

  Future<Safed<BaseException, TurnoverCardModel>> getTurnover({
    required GetTurnoverCardPayload payload,
  });

  Future<Safed<BaseException, TurnoverCardModel>> getProfit({
    required GetProfitCardPayload payload,
  });
}
