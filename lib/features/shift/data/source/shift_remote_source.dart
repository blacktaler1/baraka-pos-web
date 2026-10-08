import 'package:baraka_pos/shared/shared.dart';

import '../../../auth/presentation/screens/splash_screen.dart';
import '../data.dart';

final class ShiftRemoteSource extends RemoteSource {
  ShiftRemoteSource({required super.client});

  String get _base => "/${globalUser?.warehouseUuid}/shift";

  Future<Safed<BaseException, GetShiftsDto>> getShifts({
    required GetShiftsRequest request,
  }) async {
    return await apiGet(path: "$_base/", request: request).map(
      success: (json) => GetShiftsDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CurrentShiftDto>> currentShift({
    required CurrentShiftRequest request,
  }) async {
    return await apiGet(path: "$_base/current/", request: request).map(
      success: (json) => CurrentShiftDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CashShiftDto>> openShift({
    required OpenShiftRequest request,
  }) async {
    return await apiPost(path: "$_base/open/", request: request).map(
      success: (json) => CashShiftDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, CashShiftDto>> closeShift({
    required CloseShiftRequest request,
  }) async {
    return await apiPost(path: "$_base/${request.id}/close/", request: request)
        .map(
      success: (json) => CashShiftDto.fromJson(json),
      failure: (BaseException e) => e,
    );
  }
}
