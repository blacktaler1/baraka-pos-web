import 'package:baraka_pos/features/settings/domain/domain.dart';
import 'package:baraka_pos/shared/aplication/types/json.dart';
import 'package:baraka_pos/shared/data/data.dart';

final class UpdateShopInfoRequest extends RemoteRequest<UpdateShopInfoPayload> {
  final String shopInfo;
  final String address;
  final String conatact;
  final String phrase;

  UpdateShopInfoRequest.fromPayload(super.payload)
      : shopInfo = payload.shopInfo,
        address = payload.address,
        conatact = payload.contact,
        phrase = payload.phrase,
        super.fromPayload();

  @override
  Json data() => {
        "shop_name": shopInfo,
        "address": address,
        "contact": conatact,
        "phrase": phrase,
      };

  @override
  Map<String, String> path() => {};

  @override
  Map<String, String> query() => {};
}
