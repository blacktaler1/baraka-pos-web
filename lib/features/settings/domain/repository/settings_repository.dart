import 'package:baraka_pos/features/settings/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/aplication.dart';

abstract class SettingsRepository {
  Future<Safed<BaseException, ChangePasswordModel>> changePass({
    required ChangePasswordPayload payload,
  });

  Future<Safed<BaseException, UpdateShopInfoModel>> updateShopInfo({
    required UpdateShopInfoPayload payload,
  });

  Future<Safed<BaseException, LastVersionModel>> getLastVersion({
    required LastVersionPayload payload,
  });
}
