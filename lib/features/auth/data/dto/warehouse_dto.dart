import 'package:baraka_pos/features/auth/auth.dart';
import 'package:baraka_pos/shared/data/data.dart';

import '../../../../shared/aplication/types/json.dart';

final class WarehouseDto extends JsonDto<WarehouseModel> {
  final Json json;

  WarehouseDto.fromJson(this.json) : super.fromJson(json);

  int get id => json.integer("id");

  String get uuid => json["uuid"] ?? "";

  String get shopName => json["shop_name"] ?? "";

  String get address => json["address"] ?? "";

  String get contact => json["contact"] ?? "";

  String get phrase => json["phrase"] ?? "";

  int get owner => json.integer("owner");

  @override
  WarehouseModel model() {
    return WarehouseModel(
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
