import 'package:baraka_pos/features/settings/data/data.dart';
import 'package:baraka_pos/shared/shared.dart';

import '../../../auth/auth.dart';

final class SettingsRemouteSource extends RemoteSource {
  SettingsRemouteSource({required super.client});

  Future<Safed<BaseException, ChangePasswordDto>> changePass({
    required ChangePasswordRequest request,
  }) async {
    return await apiPut(path: "/auth/password/change/", request: request).map(
      success: dataFactory(ChangePasswordDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, UpdateShopInfoDto>> updatShopInfo({
    required UpdateShopInfoRequest request,
  }) async {
    return await apiPatch(
      path: "/${globalUser?.warehouseUuid}/shop-info/",
      request: request,
    ).map(
      success: dataFactory(UpdateShopInfoDto.fromJson),
      failure: (BaseException e) => e,
    );
  }

  Future<Safed<BaseException, LastVersionDto>> getLastVersion({
    required LastVersionRequest request,
  }) async {
    return await apiGet(path: "/version/latest/", request: request).map(
      success: dataFactory(LastVersionDto.fromJson),
      failure: (BaseException e) => e,
    );
  }
}
