import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/features/global/domain/model/device_model.dart';
import 'package:baraka_pos/features/global/domain/payload/create_device_payload.dart';

import '../../../../shared/aplication/configs/logger/talker_logger.dart';
import '../../../../shared/aplication/exceptions/base_exception.dart';
import '../../../../shared/aplication/exceptions/wrong_data_exception.dart';
import '../../../../shared/aplication/utils/safed.dart';

final class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteSource remote;
  final AuthLocalSource local;

  AuthRepositoryImpl({
    required this.remote,
    required this.local,
  });

  @override
  Future<Safed<BaseException, LoginModel>> login({
    required LoginPayload payload,
  }) async {
    final result = await remote.login(
      request: LoginRequest.fromPayload(payload),
    );

    return result.when(
      success: (dto) async {
        try {
          await local.saveLogin(
            accessToken: dto.access,
            refreshToken: dto.refresh,
            userJson: dto.user.json,
          );

          return Success<BaseException, LoginModel>(dto.model());
        } catch (e, stackTrace) {
          talker.handle(e, stackTrace, "Login ma'lumotini saqlashda xato");

          return Failure<BaseException, LoginModel>(
            WrongDataException(
              message: "Kirish ma'lumotini o'qib bo'lmadi",
              description: e.toString(),
            ),
          );
        }
      },
      failure: (e) {
        return Failure<BaseException, LoginModel>(e);
      },
    );
  }

  @override
  Future<Safed<BaseException, LoginModel>> refresh({
    required RefreshPayload payload,
  }) async {
    final result = await remote.refresh(
      request: RefreshRequest.fromPayload(payload),
    );

    return result.when(
      success: (dto) async {
        try {
          await local.updateTokens(
            accessToken: dto.access,
            refreshToken: dto.refresh,
            userJson: dto.user.json,
          );
          return Success<BaseException, LoginModel>(dto.model());
        } catch (e, stackTrace) {
          talker.handle(e, stackTrace, "Token yangilashda xato");

          return Failure<BaseException, LoginModel>(
            WrongDataException(
              message: "Kirish ma'lumotini o'qib bo'lmadi",
              description: e.toString(),
            ),
          );
        }
      },
      failure: (e) {
        return Failure<BaseException, LoginModel>(e);
      },
    );
  }

  @override
  Future<Safed<BaseException, DeviceModel>> createDevice({
    required CreateDevicePayload payload,
  }) async {
    return await remote
        .createDevice(request: CreateDeviceRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (e) => e,
        );
  }
}
