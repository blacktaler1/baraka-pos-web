import 'package:baraka_pos/features/settings/data/data.dart';
import 'package:baraka_pos/features/settings/domain/domain.dart';

import 'package:baraka_pos/shared/aplication/exceptions/base_exception.dart';
import 'package:baraka_pos/shared/aplication/utils/safed.dart';

final class SettingsRepositoryImpl extends SettingsRepository {
  final SettingsRemouteSource remote;

  SettingsRepositoryImpl({required this.remote});
  @override
  @override
  Future<Safed<BaseException, ChangePasswordModel>> changePass({
    required ChangePasswordPayload payload,
  }) async {
    return await remote
        .changePass(request: ChangePasswordRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, UpdateShopInfoModel>> updateShopInfo({
    required UpdateShopInfoPayload payload,
  }) async {
    return await remote
        .updatShopInfo(request: UpdateShopInfoRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }

  @override
  Future<Safed<BaseException, LastVersionModel>> getLastVersion({
    required LastVersionPayload payload,
  }) async {
    return await remote
        .getLastVersion(request: LastVersionRequest.fromPayload(payload))
        .map(
          success: (dto) => dto.model(),
          failure: (BaseException e) => e,
        );
  }
}
