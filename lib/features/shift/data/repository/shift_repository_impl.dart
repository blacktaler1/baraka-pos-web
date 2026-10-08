import 'package:baraka_pos/shared/shared.dart';

import '../../domain/domain.dart';
import '../data.dart';

final class ShiftRepositoryImpl extends ShiftRepository {
  final ShiftRemoteSource remote;

  ShiftRepositoryImpl({required this.remote});

  @override
  Future<Safed<BaseException, GetShiftsModel>> getShifts({
    required GetShiftsPayload payload,
  }) async {
    return await remote
        .getShifts(request: GetShiftsRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, CurrentShiftModel>> currentShift({
    required CurrentShiftPayload payload,
  }) async {
    return await remote
        .currentShift(request: CurrentShiftRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, CashShiftModel>> openShift({
    required OpenShiftPayload payload,
  }) async {
    return await remote
        .openShift(request: OpenShiftRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, CashShiftModel>> closeShift({
    required CloseShiftPayload payload,
  }) async {
    return await remote
        .closeShift(request: CloseShiftRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
