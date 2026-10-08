import 'package:baraka_pos/shared/shared.dart';

import '../domain.dart';

abstract class ShiftRepository {
  Future<Safed<BaseException, GetShiftsModel>> getShifts({
    required GetShiftsPayload payload,
  });

  Future<Safed<BaseException, CurrentShiftModel>> currentShift({
    required CurrentShiftPayload payload,
  });

  Future<Safed<BaseException, CashShiftModel>> openShift({
    required OpenShiftPayload payload,
  });

  Future<Safed<BaseException, CashShiftModel>> closeShift({
    required CloseShiftPayload payload,
  });
}
