import 'package:baraka_pos/features/home/data/data.dart';
import 'package:baraka_pos/features/home/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class DashboardRepositoryImpl extends DashboardRepository {
  final DashboardRemoteSource remote;

  DashboardRepositoryImpl({required this.remote});
  @override
  Future<Safed<BaseException, DashboardModel>> getDashboard({
    required GetDashboardPayload payload,
  }) async {
    return await remote
        .getDashboard(request: GetDashboardRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, TurnoverCardModel>> getProfit({
    required GetProfitCardPayload payload,
  }) async {
    return await remote
        .getProfitCard(request: GetProfitRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, TurnoverCardModel>> getTurnover({
    required GetTurnoverCardPayload payload,
  }) async {
    return await remote
        .getTurnoverCard(request: GetTurnoverRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
