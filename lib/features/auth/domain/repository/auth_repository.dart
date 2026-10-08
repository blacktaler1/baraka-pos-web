import 'package:baraka_pos/features/auth/domain/domain.dart';
import 'package:baraka_pos/shared/shared.dart';

import '../../../global/global.dart';

abstract class AuthRepository {
  Future<Safed<BaseException, LoginModel>> login({
    required LoginPayload payload,
  });

  Future<Safed<BaseException, LoginModel>> refresh({
    required RefreshPayload payload,
  });

  Future<Safed<BaseException, DeviceModel>> createDevice({
    required CreateDevicePayload payload,
  });
}
