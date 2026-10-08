import 'package:baraka_pos/features/settings/domain/domain.dart';

import '../../../../shared/shared.dart';

final class UpdateShopInfoDto extends JsonDto<UpdateShopInfoModel> {
  final Json json;

  UpdateShopInfoDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get uuid => json.text("uuid");

  String get shopName => json.text("shop_name");

  String get address => json.text("address");

  String get contact => json.text("contact");

  String get phrase => json.text("phrase");

  int get owner => json.integer("owner");

  @override
  UpdateShopInfoModel model() {
    return UpdateShopInfoModel(
      id: id,
      uuid: uuid,
      shopName: shopName,
      address: address,
      contact: contact,
      phrase: phrase,
      owner: owner,
    );
  }
}
