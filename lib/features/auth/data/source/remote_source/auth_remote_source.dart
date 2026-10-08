import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/data/dto/device_dto.dart';
import 'package:baraka_pos/shared/shared.dart';

final class AuthRemoteSource extends RemoteSource {
  AuthRemoteSource({required super.client});

  Future<Safed<BaseException, LoginDto>> login({
    required LoginRequest request,
  }) async {
    return await apiPost(path: "/auth/login/", request: request).map(
      success: dataFactory(LoginDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, LoginDto>> refresh({
    required RefreshRequest request,
  }) async {
    return await apiPost(path: "/auth/token/refresh/", request: request).map(
      success: dataFactory(LoginDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, DeviceDto>> createDevice({
    required CreateDeviceRequest request,
  }) async {
    return await apiPost(path: "/auth/devices/", request: request).map(
      success: dataFactory(DeviceDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
