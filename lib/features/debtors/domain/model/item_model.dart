import 'package:baraka_pos/shared/domain/domain.dart';

final class ItemModel extends Model {
  final int id;
  final String quantity;
  final String price;
  final String productTitle;
  final String productUnit;
  final num subTotal;

  const ItemModel({
    required this.id,
    required this.quantity,
    required this.price,
    required this.productTitle,
    required this.productUnit,
    required this.subTotal,
  });
  @override
  List<String> get props => [
        "id: $id",
        "quantity: $quantity",
        "price: $price",
        "productTitle: $productTitle",
        "unitTitle: $productUnit",
        "subTotal: $subTotal",
      ];
}
