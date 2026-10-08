import '../../../../shared/shared.dart';

final class UpdateShopInfoPayload extends Payload {
  final String shopInfo;
  final String address;
  final String contact;
  final String phrase;

  const UpdateShopInfoPayload({
    required this.shopInfo,
    required this.address,
    required this.contact,
    required this.phrase,
  });

  @override
  List<Object> get props => [
        "shopInfo: $shopInfo",
        "address: $address",
        "conatact: $contact",
        "phrase: $phrase",
      ];
}
