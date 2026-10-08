part of 'update_shop_info_bloc.dart';

final class UpdateShopInfoEvent extends Equatable {
  final String shopInfo;
  final String address;
  final String contact;
  final String phrase;
  const UpdateShopInfoEvent({
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
