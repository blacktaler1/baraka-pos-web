import 'package:baraka_pos/shared/domain/domain.dart';

final class WarehouseModel extends Model {
  final int id;
  final String uuid;
  final String shopName;
  final String address;
  final String contact;
  final String phrase;
  final int owner;

  const WarehouseModel({
    required this.id,
    required this.uuid,
    required this.shopName,
    required this.address,
    required this.contact,
    required this.phrase,
    required this.owner,
  });

  @override
  List<String> get props => [
        "id: $id",
        "uuid: $uuid",
        "shop_name: $shopName",
        "address: $address",
        "contact: $contact",
        "phrase: $phrase",
        "owner: $owner",
      ];
}
